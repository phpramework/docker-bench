<?php

declare(strict_types=1);

final class RoboFile extends \Robo\Tasks
{
    private function concurent(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title
    ) {
        $this->concurentPrimer($cores, $framework, $test, $uri, $title);
        $this->_exec('sleep 5');

        $this->concurentWarmUp($cores, $framework, $test, $uri, $title);
        $this->_exec('sleep 5');

        $concurencies = [8, 16, 32, 64, 128, 256];
        foreach ($concurencies as $concurency) {
            $this->concurentBenchmark(
                $cores,
                $framework,
                $test,
                $uri,
                $title,
                $concurency
            );
            $this->_exec('sleep 5');
        }
    }

    private function concurentPrimer(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title
    ) {
        $message = "Framework {$framework} : {$title} : Primer";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 5 -c 8 -t {$cores} http://app-server{$uri}"
        );

        return $result;
    }

    private function concurentWarmUp(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title
    ) {
        $message = "Framework {$framework} : {$title} : Warming Up";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 15 -c 256 -t {$cores} http://app-server{$uri}"
        );

        return $result;
    }

    private function concurentBenchmark(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title,
        int $concurency
    ) {
        $message = "Framework {$framework} : {$title} : Concurency {$concurency}";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 15 -c {$concurency} -t {$cores} http://app-server{$uri}"
        );
        file_put_contents(
            "/result/{$test}_{$concurency}.output",
            $result->getOutputData()
        );

        return $result;
    }

    private function query(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title
    ) {
        $defaultQueries = 20;

        $this->queryPrimer($cores, $framework, $test, $uri, $title, $defaultQueries);
        $this->_exec('sleep 5');

        $this->queryWarmUp($cores, $framework, $test, $uri, $title, $defaultQueries);
        $this->_exec('sleep 5');

        $queries = [1, 5, 10, 15, 20];
        foreach ($queries as $query) {
            $this->queryBenchmark(
                $cores,
                $framework,
                $test,
                $uri,
                $title,
                $query
            );
            $this->_exec('sleep 5');
        }
    }

    private function queryPrimer(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title,
        int $queries
    ) {
        $message = "Framework {$framework} : {$title} : Primer";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 5 -c 8 -t {$cores} http://app-server{$uri}{$queries}"
        );

        return $result;
    }

    private function queryWarmUp(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title,
        int $queries
    ) {
        $message = "Framework {$framework} : {$title} : Warming Up";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 15 -c 256 -t {$cores} http://app-server{$uri}{$queries}"
        );

        return $result;
    }

    private function queryBenchmark(
        int $cores,
        string $framework,
        string $test,
        string $uri,
        string $title,
        int $queries
    ) {
        $message = "Framework {$framework} : {$title} : Query {$queries}";

        $this->yell($message, 40, 'yellow');

        $result = $this->_exec(
            "wrk --latency -d 15 -c 256 -t {$cores} http://app-server{$uri}{$queries}"
        );
        file_put_contents(
            "/result/{$test}_{$queries}.output",
            $result->getOutputData()
        );

        return $result;
    }

    public function plaintext()
    {
        $this->concurent(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'plaintext',
            getenv('URI_PLAINTEXT'),
            'Plain Text'
        );
    }

    public function json()
    {
        $this->concurent(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'json',
            getenv('URI_JSON'),
            'JSON Encoding'
        );
    }

    public function db()
    {
        $this->concurent(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'db',
            getenv('URI_DB'),
            'Single Query'
        );
    }

    public function fortunes()
    {
        $this->concurent(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'fortunes',
            getenv('URI_FORTUNES'),
            'Fortunes'
        );
    }

    public function queries()
    {
        $this->query(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'queries',
            getenv('URI_QUERIES'),
            'Multiple Queries'
        );
    }

    public function updates()
    {
        $this->query(
            (int) getenv('BENCHMARK_CORES'),
            getenv('FRAMEWORK'),
            'updates',
            getenv('URI_UPDATES'),
            'Database Updates'
        );
    }
}
