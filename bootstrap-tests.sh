#!/usr/bin/env bash

if [ $# == 0 ]; then
  echo "Usage: ./bootstrap-tests.sh [app path]"
  exit -1
fi

APP_PATH="$1"

# npm install --prefix will create an 'etc' directory
# it's a known issue: https://github.com/npm/npm/pull/7249
npm install -q --prefix "$APP_PATH" mocha chai sinon --save-dev

# make the test directory
mkdir -p "$APP_PATH/test"

# create a sample test
cat << EOF > $APP_PATH/test/sample.test.js
var sinon = require('sinon');
var chai = require('chai');
var assert = chai.assert;
var expect = chai.expect;

describe('Your test scenario', function() {

  it('Should behave according to your assertions', function() {

    // test logic goes here
    assert(true);

  });

});
EOF

# additional instructions
printf '\n\e[1m%s\e[0m\n\n' 'Test bootstrapping complete!'

printf '%-5s%s\n' '1.)' 'Add the following line to your '"$APP_PATH/package.json"' "scripts" block:'
printf '%-5s%s\n\n' '' '"test": "./node_modules/mocha/bin/_mocha --recursive test/*.test.js"'

printf '%-5s%s\n' '2.)' 'Implement your tests in the "'"$APP_PATH/test"'" directory'
printf '%-5s%s\n\n' '' 'and make sure your test files use the ".test.js" file extension'

printf '%-5s%s\n\n' '' 'Review the sample.test.js file for guidance'

printf '%-5s%s\n' '3.)' 'Run your tests from the '"$APP_PATH"' directory using the following command:'
printf '%-5s%s\n' '' 'npm test'
