-- PostgreSQL DDL Script generated from EdgeQL Schema
-- Source: schema_sample.txt
-- Generated types: 153

CREATE SCHEMA IF NOT EXISTS wealthdomain;
SET search_path TO wealthdomain, public;


-- Table: AcHCreateResponse
CREATE TABLE "AcHCreateResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "requestId" VARCHAR(255)
);

-- Table: Account
CREATE TABLE "Account" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountCustodianStatus" VARCHAR(255),
    "accountIsSetUpForEDelivery" BOOLEAN,
    "accountManagementType" VARCHAR(255),
    "accountNumber" VARCHAR(255),
    "accountPrefix" VARCHAR(255),
    "accountStatus" VARCHAR(255),
    "acknowledgeIlliquidInvestment" BOOLEAN,
    "advisorTradingDiscretion" VARCHAR(255),
    "ageOfTerminationOfCustody" BIGINT,
    "allowedWithdrawalPercentage" DOUBLE PRECISION,
    "allowedYear1WithdrawalPercentage" DOUBLE PRECISION,
    "allowsSpeculation" BOOLEAN,
    "annualExpenses" DOUBLE PRECISION,
    "annualIncome" VARCHAR(30),
    "annualIncomeExact" DOUBLE PRECISION,
    "availableCredit" DOUBLE PRECISION,
    "balance" DOUBLE PRECISION,
    "balanceAsOfDate" DATE,
    "branchOrOfficeID" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "cashDividendOption" VARCHAR(40),
    "chargeInterestOnWithdrawal" BOOLEAN,
    "closureDate" DATE,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "custodialAccountType" VARCHAR(255),
    "dayOfMonthPaymentIsDue" VARCHAR(255),
    "dividendReinvestmentOption" VARCHAR(255),
    "employeeAffiliationType" VARCHAR(255),
    "employerPlanAccountNumber" VARCHAR(255),
    "estimatedValueOfInvestments" VARCHAR(30),
    "federalMarginalTaxRate" VARCHAR(30),
    "financialInformationIsForEntireHousehold" BOOLEAN,
    "firmID" VARCHAR(255),
    "frequency" VARCHAR(255),
    "guaranteedYield" DOUBLE PRECISION,
    "hsAContributionLimits" VARCHAR(255),
    "includePrimeBrokerage" BOOLEAN,
    "inheritedIRADistributionOption" VARCHAR(255),
    "initialFundingSource" VARCHAR(255),
    "initialFundingSources" VARCHAR(255),
    "interestAccrualInterval" BIGINT,
    "interestAccrualMethod" VARCHAR(255),
    "interestAccrualMinimumBalance" BIGINT,
    "interestAccrualMinimumBalanceAccountingM" VARCHAR(255),
    "interestAccrualSchedule" VARCHAR(255),
    "interestOnWithdrawalIsCumulative" BOOLEAN,
    "interestRate" DOUBLE PRECISION,
    "interestRateBonus" DOUBLE PRECISION,
    "interestRateID" VARCHAR(255),
    "investmentExperience" VARCHAR(255),
    "investmentObjective" VARCHAR(255),
    "irABeneficiaryType" VARCHAR(255),
    "irAContributionType" VARCHAR(255),
    "irADirectBeneficiaryIsSpouse" BOOLEAN,
    "irADirectBeneficiaryOrSuccessor" VARCHAR(255),
    "irAEligibleDesignatedBeneficiaryReason" VARCHAR(255),
    "irAExistingAccountFees" VARCHAR(255),
    "irAFundingSource" VARCHAR(255),
    "irAOriginalAccountConversionDate" DATE,
    "irAOriginalAccountMostRecentStatement" VARCHAR(2096),
    "irAOriginalAccountNumber" VARCHAR(255),
    "irAOriginalAccountType" VARCHAR(255),
    "irARecommendedAccountFees" VARCHAR(255),
    "irARolloverComments" VARCHAR(2000),
    "irARolloverDecision" VARCHAR(255),
    "irARolloverInvestments" VARCHAR(255),
    "irARolloverRationale" VARCHAR(255),
    "irARolloverServices" VARCHAR(255),
    "irATypeOfOwnership" VARCHAR(255),
    "isAccountForAForeignBank" BOOLEAN,
    "isAccountForPrivateBanking" BOOLEAN,
    "isEmployeeAccount" BOOLEAN,
    "isExternal" BOOLEAN,
    "isForeign" BOOLEAN,
    "isInstitutionalAccount" BOOLEAN,
    "isManaged" BOOLEAN,
    "isMasterAccount" BOOLEAN,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastPaymentAmount" DOUBLE PRECISION,
    "lastPaymentDate" DATE,
    "lastStatementDate" DATE,
    "liquidAssets" VARCHAR(30),
    "liquidAssetsExact" DOUBLE PRECISION,
    "liquidityNeeds" VARCHAR(255),
    "liquidityPreference" VARCHAR(255),
    "liquiditySufficientForAYear" BOOLEAN,
    "marginInterestDelta" DOUBLE PRECISION,
    "marginInterestMaximum" DOUBLE PRECISION,
    "marginInterestMinimum" DOUBLE PRECISION,
    "marginInterestRate" DOUBLE PRECISION,
    "marginNote" VARCHAR(255),
    "maturityDate" DATE,
    "moneyFundSweepOptIn" BOOLEAN,
    "name" VARCHAR(255),
    "netWorthExcludingHome" VARCHAR(30),
    "netWorthExcludingHomeExact" DOUBLE PRECISION,
    "nextAmountDue" DOUBLE PRECISION,
    "nextDueDate" DATE,
    "nextMinimumAmountDue" DOUBLE PRECISION,
    "nickName" VARCHAR(255),
    "optionsRiskLevel" VARCHAR(255),
    "otherInitialFundingSource" VARCHAR(255),
    "premium" DOUBLE PRECISION,
    "rateGuaranteedYears" BIGINT,
    "recordSource" VARCHAR(255),
    "recordSourceApplication" VARCHAR(255),
    "reinvestDividendsFromAllEligibleSecuriti" BOOLEAN,
    "reinvestDividendsFromMutualFunds" BOOLEAN,
    "reinvestDividendsFromNone" BOOLEAN,
    "reinvestDividendsFromSecuritiesOnly" BOOLEAN,
    "repCode" VARCHAR(255),
    "riskTolerance" VARCHAR(255),
    "saleCostBasisMethod" VARCHAR(255),
    "salesProceedsDistribution" VARCHAR(255),
    "sePIRAContributor" VARCHAR(255),
    "sePIRAEmployeeMinimumAge" BIGINT,
    "sePIRAEmployeeMinimumEmploymentYears" BIGINT,
    "sePIRAIncludeCertainNonResidentAliens" BOOLEAN,
    "sePIRAIncludeCollectiveBargaining" BOOLEAN,
    "sePIRAIncludeEmployeesUnder450" BOOLEAN,
    "securityRestrictions" TEXT,
    "shareOwnerInformationWithOwnedCorporatio" BOOLEAN,
    "siMPLEIRAAdditionalSalaryReductionElecti" BOOLEAN,
    "siMPLEIRACurrentMinimumCompensation" DOUBLE PRECISION,
    "siMPLEIRAEmployeeMayTerminateSalaryReduc" BOOLEAN,
    "siMPLEIRAEmployerContributionPercentage" DOUBLE PRECISION,
    "siMPLEIRAEmployerContributions" VARCHAR(255),
    "siMPLEIRAEmployerNonElectiveContribution" DOUBLE PRECISION,
    "siMPLEIRAExcludeEmployeesCoveredByCollec" BOOLEAN,
    "siMPLEIRAGeneralEligibilityRequirement" VARCHAR(255),
    "siMPLEIRAPriorCompensationYears" VARCHAR(255),
    "siMPLEIRAPriorMinimumCompensation" DOUBLE PRECISION,
    "siMPLEIRASalaryReductionAgreementReceM7iqk" DATE,
    "siMPLEIRASalaryReductionAgreementReceive" VARCHAR(255),
    "siMPLEIRASalaryReductionAmount" DOUBLE PRECISION,
    "siMPLEIRASalaryReductionAmountChoice" VARCHAR(255),
    "siMPLEIRASalaryReductionElectionFrequenc" VARCHAR(255),
    "siMPLEIRASalaryReductionPercentage" DOUBLE PRECISION,
    "siMPLEIRASalaryReductionStartDate" DATE,
    "specialExpenses" DOUBLE PRECISION,
    "specialExpensesTimeframe" VARCHAR(255),
    "startDate" DATE,
    "subType" VARCHAR(255),
    "suitabilityLetterDate" DATE,
    "termInMonths" BIGINT,
    "timeHorizon" VARCHAR(30),
    "totalAssets" DOUBLE PRECISION,
    "totalLiabilities" DOUBLE PRECISION,
    "tradingPrivilege" VARCHAR(255),
    "tradingPrivileges" VARCHAR(255),
    "type" VARCHAR(255),
    "wantBeneficiaries" BOOLEAN,
    "accountCommunicationPreferences_id" UUID,
    "accountCreationDetail_id" UUID,
    "accountFeatures_id" UUID,
    "annuityDetails_id" UUID,
    "assets_id" UUID,
    "associates_id" UUID,
    "beneficiaries_id" UUID,
    "branch_id" UUID,
    "client_id" UUID,
    "collateral_id" UUID,
    "contingentBeneficiaries_id" UUID,
    "custodian_id" UUID,
    "custodianForMinor_id" UUID,
    "dailyBalances_id" UUID,
    "documents_id" UUID,
    "employerContact_id" UUID,
    "feeSchedule_id" UUID,
    "governingStateLawForCustodialAccount_id" UUID,
    "holdings_id" UUID,
    "interestedParties_id" UUID,
    "intraDayBalances_id" UUID,
    "irADistributionInstructions_id" UUID,
    "irAFinancialInstitution_id" UUID,
    "jointTenancyState_id" UUID,
    "liabilities_id" UUID,
    "marginRates_id" UUID,
    "notices_id" UUID,
    "originalDepositor_id" UUID,
    "ouLevel0_id" UUID,
    "ouLevel1_id" UUID,
    "ouLevel2_id" UUID,
    "ouLevel3_id" UUID,
    "ouLevel4_id" UUID,
    "ouLevel5_id" UUID,
    "ouLevel6_id" UUID,
    "precedingOwner_id" UUID,
    "primaryOwner_id" UUID,
    "product_id" UUID,
    "registrationType_id" UUID,
    "regulatoryDisclosures_id" UUID,
    "relatedAccounts_id" UUID,
    "repCodeLink_id" UUID,
    "responsibleIndividualForMaintainingStirp_id" UUID,
    "secondaryOwners_id" UUID,
    "statementSchedule_id" UUID,
    "transfers_id" UUID
);

-- Table: AccountActivitiesResponse
CREATE TABLE "AccountActivitiesResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "insertTime" TIMESTAMP WITH TIME ZONE,
    "messages" VARCHAR(2000),
    "requestId" VARCHAR(255),
    "sequence" BIGINT,
    "status" VARCHAR(255)
);

-- Table: AccountAssociate
CREATE TABLE "AccountAssociate" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "relationshipCode" VARCHAR(255),
    "relationshipType" VARCHAR(255),
    "associate_id" UUID
);

-- Table: AccountBalances
CREATE TABLE "AccountBalances" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accruedDividends" DOUBLE PRECISION,
    "accruedInterestPurchases" DOUBLE PRECISION,
    "accruedInterestSales" DOUBLE PRECISION,
    "accumulatedFedCall" DOUBLE PRECISION,
    "availableFundsToWithdraw" DOUBLE PRECISION,
    "beginningBalance" DOUBLE PRECISION,
    "beginningBuyingPower" DOUBLE PRECISION,
    "beginningCashBalance" DOUBLE PRECISION,
    "beginningMarginBalance" DOUBLE PRECISION,
    "beginningMarketValue" DOUBLE PRECISION,
    "beginningMoneyMarketBalance" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "cashAccountCashAvailable" DOUBLE PRECISION,
    "cashAccountMarginValue" DOUBLE PRECISION,
    "cashAccountMarketValue" DOUBLE PRECISION,
    "cashManagementDDANumber" VARCHAR(255),
    "commission" DOUBLE PRECISION,
    "contributions" DOUBLE PRECISION,
    "corporateInterest" DOUBLE PRECISION,
    "creditInterest" DOUBLE PRECISION,
    "dayTradeBuyingPower" DOUBLE PRECISION,
    "endingBalance" DOUBLE PRECISION,
    "endingBuyingPower" DOUBLE PRECISION,
    "endingCashBalance" DOUBLE PRECISION,
    "endingMarginBalance" DOUBLE PRECISION,
    "endingMarketValue" DOUBLE PRECISION,
    "endingMoneyMarketBalance" DOUBLE PRECISION,
    "fedCall" DOUBLE PRECISION,
    "fundsFrozenForChecks" DOUBLE PRECISION,
    "governmentInterest" DOUBLE PRECISION,
    "houseCall" DOUBLE PRECISION,
    "intraDayTimestamp" TIMESTAMP WITH TIME ZONE,
    "liquidationValue" DOUBLE PRECISION,
    "longMarketValue" DOUBLE PRECISION,
    "longTermCapitalGains" DOUBLE PRECISION,
    "maintenanceCall" DOUBLE PRECISION,
    "marginAccountCashAvailable" DOUBLE PRECISION,
    "marginEquityAmount" DOUBLE PRECISION,
    "marginEquityPercent" DOUBLE PRECISION,
    "marketAppreciation" DOUBLE PRECISION,
    "miscellaneousCreditOrDebit" DOUBLE PRECISION,
    "moneyMarketInterest" DOUBLE PRECISION,
    "municipalInterestTax" DOUBLE PRECISION,
    "nonQualifiedDividends" DOUBLE PRECISION,
    "otherIncome" DOUBLE PRECISION,
    "partnershipDistributions" DOUBLE PRECISION,
    "periodEndDate" DATE,
    "periodStartDate" DATE,
    "periodType" VARCHAR(255),
    "previousAuthorizationLimit" DOUBLE PRECISION,
    "principalPayments" DOUBLE PRECISION,
    "qualifiedDividends" DOUBLE PRECISION,
    "recentDeposits" DOUBLE PRECISION,
    "recordSource" VARCHAR(255),
    "regulationTBuyingPower" DOUBLE PRECISION,
    "repurchaseInterest" DOUBLE PRECISION,
    "returnOfCapital" DOUBLE PRECISION,
    "royaltyPayments" DOUBLE PRECISION,
    "settlementDateBalance" DOUBLE PRECISION,
    "settlementDateCashBalance" DOUBLE PRECISION,
    "settlementDateFeeBalance" DOUBLE PRECISION,
    "settlementDateMarginBalance" DOUBLE PRECISION,
    "settlementDateShortBalance" DOUBLE PRECISION,
    "shortMarketValue" DOUBLE PRECISION,
    "shortTermCapitalGains" DOUBLE PRECISION,
    "smABalance" DOUBLE PRECISION,
    "substitutePayments" DOUBLE PRECISION,
    "tradeDateBalance" DOUBLE PRECISION,
    "tradeDateCashBalance" DOUBLE PRECISION,
    "tradeDateMarginBalance" DOUBLE PRECISION,
    "tradeDateShortBalance" DOUBLE PRECISION,
    "withdrawals" DOUBLE PRECISION,
    "account_id" UUID,
    "cashAccountSymbol_id" UUID
);

-- Table: AccountBuilder
CREATE TABLE "AccountBuilder" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountManagementType" VARCHAR(255),
    "isAccountForiegn" BOOLEAN,
    "isInstitutionalAccount" BOOLEAN,
    "isManaged" BOOLEAN,
    "wantToAddBeneficiaries" BOOLEAN,
    "accountType_id" UUID,
    "documents_id" UUID,
    "primaryOwner_id" UUID,
    "productCategory_id" UUID,
    "registrationType_id" UUID,
    "repCode_id" UUID,
    "secondaryOwners_id" UUID,
    "secondaryOwnersV2_id" UUID
);

-- Table: AccountCommunicationPreference
CREATE TABLE "AccountCommunicationPreference" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "additionalMailings" VARCHAR(255),
    "annualReports" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "communicationsTypes" VARCHAR(255),
    "corporateActions" VARCHAR(255),
    "deliveryOptions" VARCHAR(255),
    "proxies" VARCHAR(255)
);

-- Table: AccountCreation
CREATE TABLE "AccountCreation" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "isManaged" BOOLEAN,
    "category_id" UUID,
    "primaryOwner_id" UUID,
    "registrationType_id" UUID,
    "secondaryOwners_id" UUID
);

-- Table: AccountCreationDetail
CREATE TABLE "AccountCreationDetail" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumberNotAvailable" BOOLEAN,
    "applicationDate" DATE,
    "applicationNumber" TEXT,
    "beneficiarysAccountNumber" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "esignatureEnvelopeID" VARCHAR(255),
    "ibDToInitiateTransfer" BOOLEAN,
    "initialFunding" DOUBLE PRECISION,
    "offerExpiresSoon" BOOLEAN,
    "rateChangeExpectedSoon" BOOLEAN,
    "setupOnlineOrEDeliveryOfStatements" BOOLEAN,
    "statusScore" BIGINT,
    "statusScoreMaximum" BIGINT,
    "transferEtsToIRA" BOOLEAN,
    "transferToBDAInIRAApplication" BOOLEAN,
    "useBeneficiarysAccount" BOOLEAN,
    "welcomeLetterDate" DATE,
    "documents_id" UUID,
    "initialFundingCurrency_id" UUID,
    "onlineAccountSetup_id" UUID,
    "signatures_id" UUID,
    "sourceOfFunds_id" UUID
);

-- Table: AccountCreationStatusResponse
CREATE TABLE "AccountCreationStatusResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "messages" VARCHAR(2000),
    "requestId" VARCHAR(255),
    "sequence" BIGINT,
    "status" VARCHAR(255),
    "timestamp" TIMESTAMP WITH TIME ZONE
);

-- Table: AccountCreationStep
CREATE TABLE "AccountCreationStep" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" VARCHAR(255)
);

-- Table: AccountDataMapper
CREATE TABLE "AccountDataMapper" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "stepNames" VARCHAR(255),
    "steps_id" UUID
);

-- Table: AccountDueDiligenceOptions
CREATE TABLE "AccountDueDiligenceOptions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "expectInternationalTravel" BOOLEAN,
    "expectInternationalWires" BOOLEAN,
    "expectMobileDeposit" BOOLEAN,
    "expectSafeDepositBox" BOOLEAN,
    "expectedFundingMethod_id" UUID
);

-- Table: AccountFeatures
CREATE TABLE "AccountFeatures" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountPrefix" VARCHAR(255),
    "shortName" VARCHAR(255),
    "title" VARCHAR(255),
    "owner_id" UUID,
    "product_id" UUID
);

-- Table: AccountInterestedParties
CREATE TABLE "AccountInterestedParties" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "documentDelivery" VARCHAR(255),
    "relationshipToPrimary" VARCHAR(255),
    "relationshipType" VARCHAR(255),
    "party_id" UUID
);

-- Table: AccountMessages
CREATE TABLE "AccountMessages" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "additionalParameters" TEXT,
    "message" TEXT,
    "messageType" TEXT,
    "parentMessageId" BIGINT,
    "parentId_id" UUID
);

-- Table: AccountNotice
CREATE TABLE "AccountNotice" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "noticeType" VARCHAR(255),
    "noticeValue" VARCHAR(255)
);

-- Table: AccountOwnership
CREATE TABLE "AccountOwnership" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "isAddressSameAsPrimaryClient" BOOLEAN,
    "lastKYCDate" DATE,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "legalAddressStartDate" DATE,
    "ownerType" VARCHAR(255),
    "percentage" DOUBLE PRECISION,
    "relationshipToAccount" VARCHAR(255),
    "relationshipToOwner" VARCHAR(255),
    "sendTaxDocumentsToAlternateAddress" BOOLEAN,
    "spouseIsAJointOwner" BOOLEAN,
    "trustedContactInfoDeclined" BOOLEAN,
    "trustedContactRelationship" VARCHAR(255),
    "alternateMailingAddress_id" UUID,
    "dueDiligenceOptions_id" UUID,
    "legalAddress_id" UUID,
    "mailingAddress_id" UUID,
    "owner_id" UUID,
    "previousLegalAddress_id" UUID,
    "trustedContact_id" UUID
);

-- Table: AccountPrefixSettings
CREATE TABLE "AccountPrefixSettings" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountType" VARCHAR(255),
    "brokeragePrefix" VARCHAR(255),
    "managedAccountPrefix" VARCHAR(255),
    "state" VARCHAR(255)
);

-- Table: AccountRelation
CREATE TABLE "AccountRelation" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "relationship" VARCHAR(255),
    "linkedAccounts_id" UUID
);

-- Table: AccountSourceOfFunds
CREATE TABLE "AccountSourceOfFunds" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "additionalInformation" VARCHAR(255),
    "administratorName" VARCHAR(255),
    "administratorPhoneNumber" VARCHAR(50),
    "amount" DOUBLE PRECISION,
    "bankAccountHasOtherOwners" BOOLEAN,
    "bankAccountNickname" VARCHAR(255),
    "bankAccountNumber" VARCHAR(255),
    "bankAccountNumbers" VARCHAR(255),
    "bankAccountTitle" VARCHAR(255),
    "bankAccountTransferType" VARCHAR(255),
    "bankAccountType" VARCHAR(255),
    "bankBranch" VARCHAR(255),
    "bankName" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "cdMaturityDate" DATE,
    "checkIncluded" BOOLEAN,
    "checkNumber" VARCHAR(255),
    "closeAccount" BOOLEAN,
    "costBasisStepUp" BOOLEAN,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "firmName" VARCHAR(255),
    "ibANCode" VARCHAR(255),
    "intermediaryBank" VARCHAR(255),
    "intermediaryBankAccountNumber" VARCHAR(255),
    "isForeignBank" BOOLEAN,
    "isSolicitedRollover" BOOLEAN,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "otherOwnerName" VARCHAR(255),
    "partialTransferAmount" DOUBLE PRECISION,
    "payeePhoneNumber" VARCHAR(50),
    "replaceExistingInstruction" BOOLEAN,
    "rmDStatus" VARCHAR(255),
    "securitiesTransferType" VARCHAR(255),
    "sourceIRAAccountType" VARCHAR(255),
    "sourceOfFunds" VARCHAR(255),
    "swIFTCode" VARCHAR(255),
    "bankAddress_id" UUID,
    "fundingMethod_id" UUID,
    "intermediaryBankAddress_id" UUID,
    "payeeAddress_id" UUID,
    "transfer_id" UUID
);

-- Table: AccountStatementSchedule
CREATE TABLE "AccountStatementSchedule" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "alternateStatementOptions" TEXT,
    "isAlternateSchedule" BOOLEAN,
    "recurrenceInterval" BIGINT,
    "recurrenceType" VARCHAR(255)
);

-- Table: Address
CREATE TABLE "Address" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "addressProof" VARCHAR(2096),
    "addressType" VARCHAR(255),
    "addressUsage" VARCHAR(255),
    "attentionLine" VARCHAR(255),
    "attentionLinePrefix" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "city" VARCHAR(255),
    "isUSAddress" BOOLEAN,
    "line1" VARCHAR(255),
    "line2" VARCHAR(255),
    "line3" VARCHAR(255),
    "line4" VARCHAR(255),
    "postalCode" VARCHAR(255),
    "providerAssignedID" VARCHAR(255),
    "requiresAdditionalPostage" BOOLEAN,
    "stateOrProvince" VARCHAR(255),
    "useEndDate" DATE,
    "useStartDate" DATE,
    "country_id" UUID,
    "state_id" UUID
);

-- Table: AdvisorAccountBalances
CREATE TABLE "AdvisorAccountBalances" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "beginningAccounts" BIGINT,
    "beginningBuyingPower" DOUBLE PRECISION,
    "beginningCashBalance" DOUBLE PRECISION,
    "beginningEts" DOUBLE PRECISION,
    "beginningMarginBalance" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "closedAccounts" BIGINT,
    "contributions" DOUBLE PRECISION,
    "endingAccounts" BIGINT,
    "endingBuyingPower" DOUBLE PRECISION,
    "endingCashBalance" DOUBLE PRECISION,
    "endingEts" DOUBLE PRECISION,
    "endingMarginBalance" DOUBLE PRECISION,
    "marketAppreciation" DOUBLE PRECISION,
    "newAccounts" BIGINT,
    "periodEndDate" DATE,
    "periodStartDate" DATE,
    "periodType" VARCHAR(255),
    "withdrawals" DOUBLE PRECISION,
    "advisor_id" UUID
);

-- Table: AdvisorPositions
CREATE TABLE "AdvisorPositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "marketValue" DOUBLE PRECISION,
    "numberOfAccounts" BIGINT,
    "numberOfShares" BIGINT,
    "periodEndDate" DATE,
    "advisor_id" UUID,
    "security_id" UUID
);

-- Table: AggregatePositions
CREATE TABLE "AggregatePositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "aggregateType" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "marketValue" DOUBLE PRECISION,
    "numberOfAccounts" BIGINT,
    "numberOfShares" BIGINT,
    "periodEndDate" DATE,
    "advisor_id" UUID,
    "client_id" UUID,
    "orgUnit_id" UUID,
    "security_id" UUID
);

-- Table: Announcement
CREATE TABLE "Announcement" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "audience" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "display" VARCHAR(255),
    "displayEndDate" DATE,
    "displayStartDate" DATE,
    "effectiveDate" DATE,
    "expiryDate" DATE,
    "message" VARCHAR(2000),
    "noticeNumber" TEXT,
    "subject" VARCHAR(255),
    "files_id" UUID,
    "orgUnit_id" UUID
);

-- Table: AnnuityDetails
CREATE TABLE "AnnuityDetails" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "acknowledgeIlliquidInvestment" BOOLEAN,
    "allowedWithdrawalPercentage" DOUBLE PRECISION,
    "allowedYear1WithdrawalPercentage" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "chargeInterestOnWithdrawal" BOOLEAN,
    "disclosureRequirementsMet" BOOLEAN,
    "effectiveDate" DATE,
    "guaranteedYield" DOUBLE PRECISION,
    "interestOnWithdrawalIsCumulative" BOOLEAN,
    "interestRate" DOUBLE PRECISION,
    "interestRateBonus" DOUBLE PRECISION,
    "interestRateTotal" DOUBLE PRECISION,
    "isReplacement" BOOLEAN,
    "liquiditySufficientForAYear" BOOLEAN,
    "premium" DOUBLE PRECISION,
    "rateGuaranteedYears" BIGINT,
    "recentAnnuityExchange" BOOLEAN,
    "recentInvestmentActivity" BOOLEAN,
    "surrenderChargesByYear" DOUBLE PRECISION,
    "surrenderYears" BIGINT,
    "timeHorizon" VARCHAR(255),
    "type" VARCHAR(255),
    "withdrawalWindowDays" BIGINT,
    "withdrawalWindowYear" BIGINT,
    "creditingStrategies_id" UUID,
    "product_id" UUID,
    "riders_id" UUID
);

-- Table: Assets
CREATE TABLE "Assets" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "type" VARCHAR(255),
    "value" DOUBLE PRECISION
);

-- Table: Associate
CREATE TABLE "Associate" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "employer" VARCHAR(255),
    "firstName" VARCHAR(255),
    "idCode" VARCHAR(255),
    "lastName" VARCHAR(255),
    "middleName" VARCHAR(255),
    "primaryPhoneNumber" VARCHAR(50),
    "recordSource" VARCHAR(255),
    "secondaryPhoneNumber" VARCHAR(50),
    "userID" VARCHAR(255),
    "userName" VARCHAR(255),
    "address_id" UUID,
    "canAccessOrgUnits_id" UUID,
    "canAccessOrgUnitsAtOrBelow_id" UUID,
    "orgUnit_id" UUID,
    "ouLevel0_id" UUID,
    "ouLevel1_id" UUID,
    "ouLevel2_id" UUID,
    "ouLevel3_id" UUID,
    "ouLevel4_id" UUID,
    "ouLevel5_id" UUID,
    "ouLevel6_id" UUID,
    "repCodes_id" UUID
);

-- Table: AuditErrorLogs
CREATE TABLE "AuditErrorLogs" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdDate" TIMESTAMP WITH TIME ZONE,
    "createdUser" VARCHAR(255),
    "lastModifiedDate" TIMESTAMP WITH TIME ZONE,
    "logStatus" VARCHAR(255),
    "recordStatus" VARCHAR(255),
    "recordUUID" VARCHAR(255)
);

-- Table: BalancesResponse
CREATE TABLE "BalancesResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "balances_id" UUID,
    "positions_id" UUID
);

-- Table: Bank
CREATE TABLE "Bank" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bankCode" VARCHAR(255),
    "domesticWireRoutingNumber" VARCHAR(255),
    "fax" VARCHAR(50),
    "idBIGA" VARCHAR(255),
    "internationalWireRoutingNumber" BIGINT,
    "primaryPhoneNumber" VARCHAR(50),
    "secondaryPhoneNumber" VARCHAR(50),
    "swiftCode" BIGINT
);

-- Table: Beneficiary
CREATE TABLE "Beneficiary" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "beneficiaryType" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "isContingentBeneficiary" BOOLEAN,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "orderOfThisBeneficiary" BIGINT,
    "perStirM7iqk" BOOLEAN,
    "perStirpes" BOOLEAN,
    "percentage" DOUBLE PRECISION,
    "relationship" VARCHAR(255),
    "rmDOption" VARCHAR(255),
    "beneficiary_id" UUID,
    "trustedContact_id" UUID
);

-- Table: Branch
CREATE TABLE "Branch" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "branchBillingCode" VARCHAR(255),
    "branchCode" VARCHAR(255),
    "branchName" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "fax" VARCHAR(50),
    "primaryPhoneNumber" VARCHAR(50),
    "region" VARCHAR(255),
    "regionCode" VARCHAR(255),
    "secondaryPhoneNumber" VARCHAR(50),
    "address_id" UUID,
    "branchManager_id" UUID,
    "organizationalUnit_id" UUID,
    "parent_id" UUID
);

-- Table: CashFlow
CREATE TABLE "CashFlow" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accruedInterestPurchaseMTD" DOUBLE PRECISION,
    "accruedInterestPurchaseYTD" DOUBLE PRECISION,
    "accruedInterestSalesMTD" DOUBLE PRECISION,
    "accruedInterestSalesYTD" DOUBLE PRECISION,
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "corporateInterestMTD" DOUBLE PRECISION,
    "corporateInterestYTD" DOUBLE PRECISION,
    "creditInterestMTD" DOUBLE PRECISION,
    "creditInterestYTD" DOUBLE PRECISION,
    "governmentInterestMTD" DOUBLE PRECISION,
    "governmentInterestYTD" DOUBLE PRECISION,
    "liquidationsMTD" DOUBLE PRECISION,
    "liquidationsYTD" DOUBLE PRECISION,
    "longTermCapitalGainJe4tn2juge" DOUBLE PRECISION,
    "longTermCapitalGainsM7iqk" DOUBLE PRECISION,
    "longTermCapitalGainsMTD" DOUBLE PRECISION,
    "longTermCapitalGainsYTD" DOUBLE PRECISION,
    "moneyMarketMTD" DOUBLE PRECISION,
    "moneyMarketYTD" DOUBLE PRECISION,
    "municipalInterestTaxMTD" DOUBLE PRECISION,
    "municipalInterestTaxYTD" DOUBLE PRECISION,
    "nonQualifiedDividendsMTD" DOUBLE PRECISION,
    "nonQualifiedDividendsYTD" DOUBLE PRECISION,
    "otherIncomeMTD" DOUBLE PRECISION,
    "otherIncomeYTD" DOUBLE PRECISION,
    "partnershipDistributionsJe4tm" DOUBLE PRECISION,
    "partnershipDistributionsMTD" DOUBLE PRECISION,
    "partnershipDistributionsY7sc6" DOUBLE PRECISION,
    "partnershipDistributionsYTD" DOUBLE PRECISION,
    "principalPaymentsMTD" DOUBLE PRECISION,
    "principalPaymentsYTD" DOUBLE PRECISION,
    "qualifiedDividendsMTD" DOUBLE PRECISION,
    "qualifiedDividendsYTD" DOUBLE PRECISION,
    "repurchaseInterestMTD" DOUBLE PRECISION,
    "repurchaseInterestYTD" DOUBLE PRECISION,
    "returnOfCapitalMTD" DOUBLE PRECISION,
    "returnOfCapitalROCMTD" DOUBLE PRECISION,
    "returnOfCapitalROCYTD" DOUBLE PRECISION,
    "returnOfCapitalYTD" DOUBLE PRECISION,
    "royaltyPaymentsMTD" DOUBLE PRECISION,
    "royaltyPaymentsYTD" DOUBLE PRECISION,
    "shortTermCapitalGainsMTD" DOUBLE PRECISION,
    "shortTermCapitalGainsYTD" DOUBLE PRECISION,
    "substitutePaymentsMTD" DOUBLE PRECISION,
    "substitutePaymentsYTD" DOUBLE PRECISION,
    "account_id" UUID
);

-- Table: Category
CREATE TABLE "Category" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" VARCHAR(255)
);

-- Table: Client
CREATE TABLE "Client" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "annualIncome" VARCHAR(30),
    "annualIncomeExact" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "clientName" VARCHAR(255),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "federalMarginalTaxRate" VARCHAR(30),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "liquidAssets" VARCHAR(30),
    "liquidAssetsExact" DOUBLE PRECISION,
    "netWorthExcludingHome" VARCHAR(255),
    "netWorthExcludingHomeExact" DOUBLE PRECISION,
    "rating" BIGINT,
    "repCode" VARCHAR(255),
    "totalAssets" DOUBLE PRECISION,
    "totalLiabilities" DOUBLE PRECISION,
    "type" VARCHAR(255),
    "additionalMembers_id" UUID,
    "financialGoals_id" UUID,
    "investmentGoals_id" UUID,
    "primaryMember_id" UUID
);

-- Table: ClientAccountBalances
CREATE TABLE "ClientAccountBalances" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "beginningAccounts" BIGINT,
    "beginningBuyingPower" DOUBLE PRECISION,
    "beginningCashBalance" DOUBLE PRECISION,
    "beginningEts" DOUBLE PRECISION,
    "beginningMarginBalance" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "closedAccounts" BIGINT,
    "contributions" DOUBLE PRECISION,
    "endingAccounts" BIGINT,
    "endingBuyingPower" DOUBLE PRECISION,
    "endingCashBalance" DOUBLE PRECISION,
    "endingEts" DOUBLE PRECISION,
    "endingMarginBalance" DOUBLE PRECISION,
    "marketAppreciation" DOUBLE PRECISION,
    "newAccounts" BIGINT,
    "periodEndDate" DATE,
    "periodStartDate" DATE,
    "periodType" VARCHAR(255),
    "withdrawals" DOUBLE PRECISION,
    "advisor_id" UUID,
    "client_id" UUID
);

-- Table: ClientMember
CREATE TABLE "ClientMember" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "j_Primary" BOOLEAN,
    "relationship" VARCHAR(255),
    "member_id" UUID
);

-- Table: ClientPositions
CREATE TABLE "ClientPositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "marketValue" DOUBLE PRECISION,
    "numberOfAccounts" BIGINT,
    "numberOfShares" BIGINT,
    "periodEndDate" DATE,
    "advisor_id" UUID,
    "client_id" UUID,
    "security_id" UUID
);

-- Table: Collateral
CREATE TABLE "Collateral" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "description" VARCHAR(255),
    "isReleased" BOOLEAN,
    "priority" BIGINT,
    "serialNumber" VARCHAR(255),
    "type" VARCHAR(255),
    "loan_id" UUID
);

-- Table: Commissions
CREATE TABLE "Commissions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "commissions" DOUBLE PRECISION,
    "commissionsMTD" DOUBLE PRECISION,
    "commissionsYTD" DOUBLE PRECISION,
    "tickets" DOUBLE PRECISION,
    "ticketsMTD" DOUBLE PRECISION,
    "ticketsYTD" DOUBLE PRECISION,
    "associate_id" UUID,
    "commissionsByProduct_id" UUID,
    "exchange_id" UUID,
    "product_id" UUID
);

-- Table: CommissionsByProduct
CREATE TABLE "CommissionsByProduct" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "commissions" DOUBLE PRECISION,
    "commissionsMTD" DOUBLE PRECISION,
    "commissionsYTD" DOUBLE PRECISION,
    "tickets" BIGINT,
    "ticketsMTD" BIGINT,
    "ticketsYTD" BIGINT,
    "exchange_id" UUID,
    "product_id" UUID
);

-- Table: ConfigSchema
CREATE TABLE "ConfigSchema" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "settingName" VARCHAR(255),
    "settingValue" VARCHAR(255)
);

-- Table: Country
CREATE TABLE "Country" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code2Letters" VARCHAR(255),
    "code3Letters" VARCHAR(255),
    "fullName" VARCHAR(255),
    "shortName" VARCHAR(255),
    "sortOrder" BIGINT
);

-- Table: CreateAccountResponse
CREATE TABLE "CreateAccountResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountId" VARCHAR(255),
    "requestId" VARCHAR(255),
    "statusMsg" VARCHAR(255)
);

-- Table: Currency
CREATE TABLE "Currency" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "alphabeticCode" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "countryCode" VARCHAR(255),
    "issuingEntity" VARCHAR(255),
    "minorUnits" BIGINT,
    "name" VARCHAR(255),
    "numericCode" VARCHAR(255),
    "sortOrder" BIGINT,
    "symbol" VARCHAR(255)
);

-- Table: Custodian
CREATE TABLE "Custodian" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code" VARCHAR(255),
    "name" VARCHAR(255)
);

-- Table: Customemail
CREATE TABLE "Customemail" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "attachments" TEXT,
    "bcc" TEXT,
    "cc" TEXT,
    "emailpriority" TEXT,
    "htmlBody" TEXT,
    "providerName" TEXT,
    "subject" TEXT,
    "textBody" TEXT,
    "to" TEXT
);

-- Table: Document
CREATE TABLE "Document" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "description" VARCHAR(255),
    "document" VARCHAR(2096),
    "documentStatus" VARCHAR(255),
    "documentType" VARCHAR(255),
    "externalId" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "tag" VARCHAR(255)
);

-- Table: EnumerationOptions
CREATE TABLE "EnumerationOptions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "color" VARCHAR(255),
    "description" VARCHAR(255),
    "disabled" BOOLEAN,
    "domainName" VARCHAR(255),
    "enumerationName" VARCHAR(255),
    "icon" VARCHAR(255),
    "isDefault" BOOLEAN,
    "optionLabel" VARCHAR(1500),
    "optionOrder" BIGINT,
    "optionValue" VARCHAR(255),
    "orgUnitCode" VARCHAR(255)
);

-- Table: Error
CREATE TABLE "Error" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "field" VARCHAR(255)
);

-- Table: EsignatureEnvelope
CREATE TABLE "EsignatureEnvelope" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "envelopeStatus" VARCHAR(255),
    "documents_id" UUID
);

-- Table: EsignaturePositions
CREATE TABLE "EsignaturePositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "datePageNumber" BIGINT,
    "dateXPosition" BIGINT,
    "dateYPosition" BIGINT,
    "index" BIGINT,
    "initialsPageNumber" BIGINT,
    "initialsXPosition" BIGINT,
    "initialsYPosition" BIGINT,
    "namePageNumber" BIGINT,
    "nameXPosition" BIGINT,
    "nameYPosition" BIGINT,
    "rowNumber" BIGINT,
    "signPageNumber" BIGINT,
    "signXPosition" BIGINT,
    "signYPosition" BIGINT,
    "signerType" VARCHAR(255)
);

-- Table: Exchange
CREATE TABLE "Exchange" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "custodianCode" VARCHAR(255),
    "description" VARCHAR(255),
    "exchangeCode" VARCHAR(255),
    "name" VARCHAR(255)
);

-- Table: ExecutionHistory
CREATE TABLE "ExecutionHistory" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "executionTime" INTERVAL,
    "jobName" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "message" VARCHAR(255),
    "status" VARCHAR(255),
    "stepType" VARCHAR(255),
    "inputFiles_id" UUID,
    "outputFiles_id" UUID,
    "steps_id" UUID
);

-- Table: ExecutionHistoryStep
CREATE TABLE "ExecutionHistoryStep" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "executionTime" INTERVAL,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "message" VARCHAR(255),
    "status" VARCHAR(255),
    "stepName" VARCHAR(255),
    "stepType" VARCHAR(255),
    "expectedFiles_id" UUID
);

-- Table: ExpectedFile
CREATE TABLE "ExpectedFile" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "businessObject" VARCHAR(255),
    "domainName" VARCHAR(255),
    "expectedDays" VARCHAR(255),
    "expectedTime" TIMESTAMP WITH TIME ZONE,
    "folder" VARCHAR(255),
    "frequency" VARCHAR(255),
    "name" VARCHAR(255),
    "namePattern" VARCHAR(255),
    "timeout" INTERVAL
);

-- Table: FeeSchedule
CREATE TABLE "FeeSchedule" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "discount" DOUBLE PRECISION,
    "minimumFees" BIGINT,
    "name" VARCHAR(255),
    "tier1" BIGINT,
    "tier1Rate" DOUBLE PRECISION,
    "tier2" BIGINT,
    "tier2Rate" DOUBLE PRECISION,
    "tier3" BIGINT,
    "tier3Rate" DOUBLE PRECISION,
    "tier4" BIGINT,
    "tier4Rate" DOUBLE PRECISION,
    "tier5" BIGINT,
    "tier5Rate" DOUBLE PRECISION,
    "tieredRate" BOOLEAN,
    "topTierRate" DOUBLE PRECISION
);

-- Table: FinancialGoal
CREATE TABLE "FinancialGoal" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "endYear" BIGINT,
    "goalAmount" DOUBLE PRECISION,
    "initialContribution" DOUBLE PRECISION,
    "investmentModel" VARCHAR(255),
    "livingExpenses" DOUBLE PRECISION,
    "name" VARCHAR(255),
    "recurringContribution" DOUBLE PRECISION,
    "recurringContributionFrequency" VARCHAR(255),
    "recurringContributionRate" DOUBLE PRECISION,
    "riskLevel" VARCHAR(255),
    "startYear" BIGINT,
    "type" VARCHAR(255),
    "accounts_id" UUID,
    "extRetirementGoal_id" UUID,
    "participants_id" UUID,
    "retirementState_id" UUID
);

-- Table: FinancialInstitution
CREATE TABLE "FinancialInstitution" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bankCK2vyw" VARCHAR(255),
    "bankCode" VARCHAR(255),
    "domesticWireRoutingNumber" VARCHAR(255),
    "fax" VARCHAR(50),
    "internationalWireRoutingNumber" BIGINT,
    "name" VARCHAR(255),
    "primaryPhoneNumber" VARCHAR(50),
    "secondaryPhoneNumber" VARCHAR(50),
    "swiftCode" BIGINT,
    "additionalRoutingNumbers_id" UUID,
    "address_id" UUID,
    "organizationalUnit_id" UUID
);

-- Table: FormGenerationCriteria
CREATE TABLE "FormGenerationCriteria" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "client" VARCHAR(255),
    "displayOrder" BIGINT,
    "docCategory" VARCHAR(255),
    "docTypeName" VARCHAR(255),
    "domainModel" VARCHAR(255),
    "label" VARCHAR(255),
    "rawFile" VARCHAR(2096),
    "serviceRequestLabel" VARCHAR(255),
    "uploadDocumentToCustodian" BOOLEAN,
    "esignatureDetails_id" UUID
);

-- Table: FormsByRegistrationType
CREATE TABLE "FormsByRegistrationType" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "conditions" VARCHAR(255),
    "custodian" VARCHAR(255),
    "form" VARCHAR(2096),
    "formName" VARCHAR(255),
    "formType" VARCHAR(255),
    "registrationType" VARCHAR(255)
);

-- Table: FundingMethodTypes
CREATE TABLE "FundingMethodTypes" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(2000),
    "fundingMethod" VARCHAR(255),
    "icon" VARCHAR(2096),
    "sortOrder" BIGINT
);

-- Table: GenericErrorResponse
CREATE TABLE "GenericErrorResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "data" VARCHAR(2000),
    "error" VARCHAR(2000)
);

-- Table: GetRCHKResponse
CREATE TABLE "GetRCHKResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "accountType" VARCHAR(255),
    "alternateNameAndAddressOrigin" VARCHAR(255),
    "approver1Date" VARCHAR(255),
    "approver1Initials" VARCHAR(255),
    "approver1WhoCode" VARCHAR(255),
    "approver2Date" VARCHAR(255),
    "approver2Initials" VARCHAR(255),
    "approver2WhoCode" VARCHAR(255),
    "approver3Date" VARCHAR(255),
    "approver3Initials" VARCHAR(255),
    "approver3WhoCode" VARCHAR(255),
    "asOfFuturePayDate" VARCHAR(255),
    "assignedWirePrinterId" VARCHAR(255),
    "autoAlignmentSwitch" VARCHAR(255),
    "bankNumber" VARCHAR(255),
    "branchPrintSwitch" VARCHAR(255),
    "branchRepSeparationBranch" VARCHAR(255),
    "cashStandingInstructionCodes" VARCHAR(255),
    "checkApprovalOverride" VARCHAR(255),
    "checkInstructions1" VARCHAR(255),
    "checkInstructions2" VARCHAR(255),
    "checkNextBusinessDate" VARCHAR(255),
    "checkPrintedBranch" VARCHAR(255),
    "checkPrintedDate" VARCHAR(255),
    "checkPrinterDescription" VARCHAR(255),
    "checkPrinterFeedSettings" VARCHAR(255),
    "checkPrinterId" VARCHAR(255),
    "checkPrinterStatus" VARCHAR(255),
    "checkPurpose" VARCHAR(255),
    "checkRequestDate" VARCHAR(255),
    "checkStatusCode" VARCHAR(255),
    "checkSystemType" VARCHAR(255),
    "checkType" VARCHAR(255),
    "controlNumber" VARCHAR(255),
    "departmentCode" VARCHAR(255),
    "detailSourceCode" VARCHAR(255),
    "federalTaxWithholdingPercentage" VARCHAR(255),
    "federalWithholdingTypeCode" VARCHAR(255),
    "fifthNameAndAddressLine" VARCHAR(255),
    "firmDefinedGlopProfileCode" VARCHAR(255),
    "firstNameAndAddressLine" VARCHAR(255),
    "fourthNameAndAddressLine" VARCHAR(255),
    "historicalStatusIndicator" VARCHAR(255),
    "itemNumberOfPayeeInstructions" VARCHAR(255),
    "lastCheckNumberPrinted" VARCHAR(255),
    "lastUpdateDate" VARCHAR(255),
    "lastUpdatedDepartmentCode" VARCHAR(255),
    "marginStandingInstructionCode" VARCHAR(255),
    "messageFromApprover1" VARCHAR(255),
    "messageFromApprover2" VARCHAR(255),
    "messageToApprover1" VARCHAR(255),
    "messageToApprover2" VARCHAR(255),
    "mmfSymbol" VARCHAR(255),
    "originatorInitials" VARCHAR(255),
    "portionOfCheckAmount" VARCHAR(255),
    "rejectorWhoCode" VARCHAR(255),
    "repCode" VARCHAR(255),
    "requestUpdateInitials" VARCHAR(255),
    "reservedForFutureUse" VARCHAR(255),
    "rowIdentifier" VARCHAR(255),
    "secondNameAndAddressLine" VARCHAR(255),
    "sequenceNumber" VARCHAR(255),
    "sixthNameAndAddressLine" VARCHAR(255),
    "sourceCode" VARCHAR(255),
    "stateTaxWithholdingPercentage" VARCHAR(255),
    "stateWithholdingTypeCode" VARCHAR(255),
    "subfirm" VARCHAR(255),
    "taxId" VARCHAR(255),
    "thirdNameAndAddressLine" VARCHAR(255),
    "transactionReferenceId" VARCHAR(255),
    "typeOfPayee" VARCHAR(255),
    "uniqueTimestamp" VARCHAR(255),
    "whoCodeOfUserPrintedCheck" VARCHAR(255),
    "wireNumber" VARCHAR(255)
);

-- Table: Holdings
CREATE TABLE "Holdings" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "nonQualifiedValue" DOUBLE PRECISION,
    "qualifiedValue" DOUBLE PRECISION,
    "type" VARCHAR(255)
);

-- Table: IndexedAnnuityCreditingStrategy
CREATE TABLE "IndexedAnnuityCreditingStrategy" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "currentRate" DOUBLE PRECISION,
    "interestCreditingStrategy" VARCHAR(255),
    "interestRateMargin" DOUBLE PRECISION,
    "minimumCapRate" DOUBLE PRECISION,
    "participationRate" DOUBLE PRECISION
);

-- Table: InterestRateChange
CREATE TABLE "InterestRateChange" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "rateChangeTrigger" VARCHAR(255),
    "triggerRateFactor" BIGINT,
    "triggerRateVariation" BIGINT
);

-- Table: InvestmentProgramType
CREATE TABLE "InvestmentProgramType" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "name" VARCHAR(255)
);

-- Table: J_Transaction
CREATE TABLE "J_Transaction" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "amount" DOUBLE PRECISION,
    "blotterCode" VARCHAR(255),
    "branchOrOfficeID" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "cancelCode" VARCHAR(255),
    "category" VARCHAR(255),
    "categorySource" VARCHAR(255),
    "checkOrTradeTicketNumber" VARCHAR(255),
    "code" VARCHAR(255),
    "commission" DOUBLE PRECISION,
    "contributionOrWithdrawal" VARCHAR(255),
    "creditOrDebit" VARCHAR(255),
    "currencyCode" VARCHAR(255),
    "cusip" VARCHAR(255),
    "custodianAssignedSecurityID" VARCHAR(255),
    "custodianCharge" DOUBLE PRECISION,
    "custodianName" VARCHAR(255),
    "custodianRepCode" VARCHAR(255),
    "dealerCommissionRate" DOUBLE PRECISION,
    "enteredBy" VARCHAR(255),
    "feeAmount" DOUBLE PRECISION,
    "initialSourceOfFunds" VARCHAR(255),
    "intermediary" VARCHAR(255),
    "intraDayTimestamp" TIMESTAMP WITH TIME ZONE,
    "isPhysical" BOOLEAN,
    "isSolicited" BOOLEAN,
    "isTradeTransaction" BOOLEAN,
    "isin" VARCHAR(255),
    "journalInOrOut" VARCHAR(255),
    "longDescription" VARCHAR(2000),
    "marketCode" VARCHAR(255),
    "merchant" VARCHAR(255),
    "merchantType" VARCHAR(255),
    "mutualFundValues" VARCHAR(255),
    "orderType" VARCHAR(255),
    "originalCommission" DOUBLE PRECISION,
    "postDate" DATE,
    "price" DOUBLE PRECISION,
    "principal" DOUBLE PRECISION,
    "processedDate" DATE,
    "quantity" DOUBLE PRECISION,
    "recordSource" VARCHAR(255),
    "repCode" VARCHAR(255),
    "runningBalaJe4tm" DOUBLE PRECISION,
    "runningBalance" DOUBLE PRECISION,
    "securityDescription" VARCHAR(255),
    "sedol" VARCHAR(255),
    "settlementDate" DATE,
    "shortDescription" VARCHAR(255),
    "status" VARCHAR(255),
    "symbol" VARCHAR(255),
    "tradeDate" DATE,
    "transactionCode" VARCHAR(255),
    "transactionDate" DATE,
    "transactionID" VARCHAR(255),
    "transactionRecordSource" VARCHAR(255),
    "transactionType" VARCHAR(255),
    "valoren" VARCHAR(255),
    "account_id" UUID,
    "ouLevel0_id" UUID,
    "ouLevel1_id" UUID,
    "ouLevel2_id" UUID,
    "ouLevel3_id" UUID,
    "ouLevel4_id" UUID,
    "ouLevel5_id" UUID,
    "ouLevel6_id" UUID,
    "security_id" UUID
);

-- Table: KeyValuePair
CREATE TABLE "KeyValuePair" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "key" VARCHAR(255),
    "value" VARCHAR(255)
);

-- Table: KyCInfo
CREATE TABLE "KyCInfo" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "description" VARCHAR(255),
    "kyCStatus" VARCHAR(255),
    "kyCVerificationType" VARCHAR(255)
);

-- Table: Liabilities
CREATE TABLE "Liabilities" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "type" VARCHAR(255),
    "value" DOUBLE PRECISION
);

-- Table: MarginInterest
CREATE TABLE "MarginInterest" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "branchMarginInterest" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "interest" DOUBLE PRECISION,
    "isBulkPost" BOOLEAN,
    "marginMTD" DOUBLE PRECISION,
    "postDate" DATE,
    "postUserCode" VARCHAR(255),
    "account_id" UUID
);

-- Table: MarginRates
CREATE TABLE "MarginRates" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "rangeMaximum" DOUBLE PRECISION,
    "rangeMinimum" DOUBLE PRECISION,
    "rate" DOUBLE PRECISION,
    "rateDelta" DOUBLE PRECISION,
    "rateDeltaIsPositive" BOOLEAN
);

-- Table: MarginRequirements
CREATE TABLE "MarginRequirements" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "category" VARCHAR(255),
    "firmMarketValueRequired" DOUBLE PRECISION,
    "firmPrincipalRequired" DOUBLE PRECISION,
    "maintenancePoints" DOUBLE PRECISION,
    "marginCallThreshold" DOUBLE PRECISION,
    "priceBreak" DOUBLE PRECISION,
    "regulationTMarketValueRequired" DOUBLE PRECISION,
    "regulationTPrincipalRequired" DOUBLE PRECISION,
    "orgUnit_id" UUID
);

-- Table: MultiAccountBuilder
CREATE TABLE "MultiAccountBuilder" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountCreationList_id" UUID
);

-- Table: MultiAccountCreation
CREATE TABLE "MultiAccountCreation" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountCreationList_id" UUID
);

-- Table: NoteResponse
CREATE TABLE "NoteResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "addTimestamp" VARCHAR(255),
    "alphaKey" VARCHAR(255),
    "changeDateCYMD" VARCHAR(255),
    "changeWhoCode" VARCHAR(255),
    "effectiveDateCYMD" VARCHAR(255),
    "note" VARCHAR(255),
    "padType" VARCHAR(255)
);

-- Table: OnlineAccountSecurityQA
CREATE TABLE "OnlineAccountSecurityQA" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "answer" VARCHAR(255),
    "question" VARCHAR(255)
);

-- Table: OnlineAccountSecurityQuestions
CREATE TABLE "OnlineAccountSecurityQuestions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "enabled" BOOLEAN,
    "question" VARCHAR(255)
);

-- Table: OnlineAccountSetup
CREATE TABLE "OnlineAccountSetup" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "firstChoiceForUserID" VARCHAR(255),
    "secondChoiceForUserID" VARCHAR(255),
    "accountsToLink_id" UUID,
    "person_id" UUID,
    "securityQuestionsAndAnswers_id" UUID
);

-- Table: OrgUnitAccountBalances
CREATE TABLE "OrgUnitAccountBalances" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "beginningAccounts" BIGINT,
    "beginningBuyingPower" DOUBLE PRECISION,
    "beginningCashBalance" DOUBLE PRECISION,
    "beginningEts" DOUBLE PRECISION,
    "beginningMarginBalance" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "closedAccounts" BIGINT,
    "contributions" DOUBLE PRECISION,
    "endingAccounts" BIGINT,
    "endingBuyingPower" DOUBLE PRECISION,
    "endingCashBalance" DOUBLE PRECISION,
    "endingEts" DOUBLE PRECISION,
    "endingMarginBalance" DOUBLE PRECISION,
    "newAccounts" BIGINT,
    "periodEndDate" DATE,
    "periodStartDate" DATE,
    "periodType" VARCHAR(255),
    "withdrawals" DOUBLE PRECISION,
    "orgUnit_id" UUID,
    "ouLevel0_id" UUID,
    "ouLevel1_id" UUID,
    "ouLevel2_id" UUID,
    "ouLevel3_id" UUID,
    "ouLevel4_id" UUID,
    "ouLevel5_id" UUID,
    "ouLevel6_id" UUID
);

-- Table: OrgUnitPositions
CREATE TABLE "OrgUnitPositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "marketValue" DOUBLE PRECISION,
    "numberOfAccounts" BIGINT,
    "numberOfShares" BIGINT,
    "periodEndDate" DATE,
    "orgUnit_id" UUID,
    "ouLevel0_id" UUID,
    "ouLevel1_id" UUID,
    "ouLevel2_id" UUID,
    "ouLevel3_id" UUID,
    "ouLevel4_id" UUID,
    "ouLevel5_id" UUID,
    "ouLevel6_id" UUID,
    "security_id" UUID
);

-- Table: OrgUnitRelation
CREATE TABLE "OrgUnitRelation" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "childUnit_id" UUID,
    "parentUnit_id" UUID
);

-- Table: OrgUnitType
CREATE TABLE "OrgUnitType" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "level" BIGINT,
    "name" VARCHAR(255)
);

-- Table: OrganizationalUnit
CREATE TABLE "OrganizationalUnit" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "billingCode" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code" VARCHAR(255),
    "description" VARCHAR(255),
    "name" VARCHAR(255),
    "omsId" VARCHAR(255),
    "parentCode" VARCHAR(255),
    "primaryPhoneNumber" VARCHAR(50),
    "secondaryPhoneNumber" VARCHAR(50),
    "taxID" VARCHAR(255),
    "type" VARCHAR(255),
    "address_id" UUID,
    "childUnits_id" UUID
);

-- Table: OutputFile
CREATE TABLE "OutputFile" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "domainName" VARCHAR(255),
    "fileName" VARCHAR(255),
    "isNIGO" BOOLEAN,
    "j_Size" BIGINT,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "name" VARCHAR(255),
    "rows" BIGINT,
    "targetBusinessObject" VARCHAR(255),
    "expectedFiles_id" UUID
);

-- Table: Person
CREATE TABLE "Person" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "alias" VARCHAR(255),
    "annualExpenses" DOUBLE PRECISION,
    "annualIncome" VARCHAR(30),
    "annualIncomeExact" DOUBLE PRECISION,
    "backupWithholdingExemptPayeeCode" VARCHAR(255),
    "beneficiariesAreNaturalPersons" BOOLEAN,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "businessPhoneNumber" VARCHAR(50),
    "citizenshipStatus" VARCHAR(255),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "customerFileID" VARCHAR(255),
    "dateOfBirth" DATE,
    "dateOfDeath" DATE,
    "ein" VARCHAR(255),
    "employer" VARCHAR(255),
    "employerPhoneNumber" VARCHAR(50),
    "employmentDate" DATE,
    "employmentStatus" VARCHAR(255),
    "exemptFromBackupWithholding" BOOLEAN,
    "faTCAReportingExemptionCode" VARCHAR(255),
    "federalMarginalTaxRate" VARCHAR(30),
    "firstName" VARCHAR(255),
    "fullName" VARCHAR(255),
    "gender" VARCHAR(255),
    "homeOwnership" VARCHAR(255),
    "investmentExperience" VARCHAR(255),
    "investmentExperienceAlternatives" BIGINT,
    "investmentExperienceAlternativesTransact" TEXT,
    "investmentExperienceAnnuities" VARCHAR(30),
    "investmentExperienceAnnuitiesTransaction" TEXT,
    "investmentExperienceDate" DATE,
    "investmentExperienceDirectedParticipa5e2dc" TEXT,
    "investmentExperienceDirectedParticipatio" VARCHAR(30),
    "investmentExperienceEquities" VARCHAR(30),
    "investmentExperienceEquitiesTransactions" VARCHAR(30),
    "investmentExperienceFixedAnnuities" BIGINT,
    "investmentExperienceFixedIncome" VARCHAR(30),
    "investmentExperienceFixedIncomeTransacti" TEXT,
    "investmentExperienceFutures" BIGINT,
    "investmentExperienceFuturesTransactions" TEXT,
    "investmentExperienceLevelAlternatives" VARCHAR(255),
    "investmentExperienceLevelAnnuities" VARCHAR(255),
    "investmentExperienceLevelDirectedPartici" VARCHAR(255),
    "investmentExperienceLevelEquities" VARCHAR(255),
    "investmentExperienceLevelFixedAnnuities" VARCHAR(255),
    "investmentExperienceLevelFixedIncome" VARCHAR(255),
    "investmentExperienceLevelFutures" VARCHAR(255),
    "investmentExperienceLevelManagedMoney" VARCHAR(255),
    "investmentExperienceLevelMutualFunds" VARCHAR(255),
    "investmentExperienceLevelOptions" VARCHAR(255),
    "investmentExperienceLevelREIT" VARCHAR(255),
    "investmentExperienceLevelRealEstate" VARCHAR(255),
    "investmentExperienceLevelVariableAnnuiti" VARCHAR(255),
    "investmentExperienceManagedMoney" BIGINT,
    "investmentExperienceMargin" BIGINT,
    "investmentExperienceMarginTransactions" TEXT,
    "investmentExperienceMutualFunds" VARCHAR(30),
    "investmentExperienceMutualFundsTransacti" TEXT,
    "investmentExperienceOptions" VARCHAR(30),
    "investmentExperienceOptionsTransactions" VARCHAR(30),
    "investmentExperienceREIT" VARCHAR(30),
    "investmentExperienceREITTransactions" BIGINT,
    "investmentExperienceRealEstate" VARCHAR(30),
    "investmentExperienceRealEstateTransactio" TEXT,
    "investmentExperienceVariableAnnuities" BIGINT,
    "isClientRecord" BOOLEAN,
    "isResidingInCommunityPropertyState" BOOLEAN,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "lastName" VARCHAR(255),
    "legalAddressIsMailingAddress" BOOLEAN,
    "legalAddressLengthOfStay" VARCHAR(255),
    "legalAddressStartDate" DATE,
    "liquidAssets" VARCHAR(30),
    "liquidAssetsExact" DOUBLE PRECISION,
    "maritalStatus" VARCHAR(255),
    "middleName" VARCHAR(255),
    "natureOfBusiness" VARCHAR(255),
    "netWorthExcludingHome" TEXT,
    "netWorthExcludingHomeExact" DOUBLE PRECISION,
    "numberOfDependents" BIGINT,
    "occupation" VARCHAR(255),
    "ofACReportingExempted" BOOLEAN,
    "personType" VARCHAR(255),
    "powersOfTrustee" VARCHAR(255),
    "preferredName" VARCHAR(255),
    "primaryPhoneIsMobile" BOOLEAN,
    "primaryPhoneNumber" VARCHAR(50),
    "profilePicture" VARCHAR(2096),
    "providerAssignedID" VARCHAR(255),
    "recordSource" VARCHAR(255),
    "recordSourceAssignedID" VARCHAR(255),
    "secondaryPhoneIsMobile" BOOLEAN,
    "secondaryPhoneNumber" VARCHAR(50),
    "securityQuestion1Answer" VARCHAR(255),
    "securityQuestion2Answer" VARCHAR(255),
    "securityQuestion3Answer" VARCHAR(255),
    "securityQuestion4Answer" VARCHAR(255),
    "securityQuestion5Answer" VARCHAR(255),
    "specialExpenses" DOUBLE PRECISION,
    "suffix" VARCHAR(255),
    "taxClassification" VARCHAR(255),
    "taxExemptionStatus" VARCHAR(255),
    "taxIDType" VARCHAR(255),
    "title" VARCHAR(255),
    "titleAtEmployer" VARCHAR(255),
    "totalAssets" DOUBLE PRECISION,
    "totalLiabilities" DOUBLE PRECISION,
    "trustAmendmentDate" DATE,
    "trustIsDulyOrganized" BOOLEAN,
    "trustType" VARCHAR(255),
    "trusteesAreNaturalPersons" BOOLEAN,
    "trusteesCanActIndividually" BOOLEAN,
    "withholdingOptions" VARCHAR(255),
    "yeMployed" BIGINT,
    "accreditedInvestor_id" UUID,
    "alternateMailingAddress_id" UUID,
    "assets_id" UUID,
    "associatedWithBrokerDealer_id" UUID,
    "associatedWithInvestmentAdvisor_id" UUID,
    "associatedWithOtherBrokerDealer_id" UUID,
    "beneficiaries_id" UUID,
    "contingentBeneficiaries_id" UUID,
    "countryOfCitizenship_id" UUID,
    "countryOfResidence_id" UUID,
    "employerAddress_id" UUID,
    "foreignOfficial_id" UUID,
    "governingStateLawForTrust_id" UUID,
    "grantor_id" UUID,
    "holdings_id" UUID,
    "kyCInfo_id" UUID,
    "legalAddress_id" UUID,
    "liabilities_id" UUID,
    "mailingAddress_id" UUID,
    "otherDocuments_id" UUID,
    "previousLegalAddress_id" UUID,
    "proofOfAddress_id" UUID,
    "proofOfIdentity_id" UUID,
    "proofOfIncome_id" UUID,
    "publicCompanyOfficial_id" UUID,
    "regulatoryDisclosuresV0_id" UUID,
    "relatedPersons_id" UUID,
    "relatedToPublicCompanyOfficial_id" UUID,
    "revoker_id" UUID,
    "secondCountryOfCitizenship_id" UUID,
    "securitiesIndustryAffiliation_id" UUID,
    "securityQuestionsAndAnswers_id" UUID,
    "spouse_id" UUID,
    "successorTrustee_id" UUID,
    "trustee_id" UUID
);

-- Table: PersonRelation
CREATE TABLE "PersonRelation" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "ownershipPercentage" DOUBLE PRECISION,
    "relationship" VARCHAR(255),
    "tradingAuthority" DOUBLE PRECISION,
    "sourcePerson_id" UUID,
    "targetPerson_id" UUID
);

-- Table: Position
CREATE TABLE "Position" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accruedAmount" DOUBLE PRECISION,
    "annuityProvider" VARCHAR(255),
    "asOfDate" DATE,
    "blendedUnitCost" DOUBLE PRECISION,
    "bondCallType" VARCHAR(255),
    "bondFactor" DOUBLE PRECISION,
    "bondType" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "callOrPut" VARCHAR(255),
    "contractNumber" VARCHAR(255),
    "contractValue" DOUBLE PRECISION,
    "costBasis" DOUBLE PRECISION,
    "couponRate" DOUBLE PRECISION,
    "cusip" VARCHAR(255),
    "custodianAssignedSecurityID" VARCHAR(255),
    "description" VARCHAR(255),
    "dividendRate" DOUBLE PRECISION,
    "duration" VARCHAR(255),
    "expiryDate" DATE,
    "firstCouponDate" DATE,
    "held" VARCHAR(255),
    "instrumentType" VARCHAR(255),
    "intraDayPriceChange" DOUBLE PRECISION,
    "intraDayTimestamp" TIMESTAMP WITH TIME ZONE,
    "isMarginable" BOOLEAN,
    "isin" VARCHAR(255),
    "lastSettlementDate" DATE,
    "lastTradeDate" DATE,
    "location" VARCHAR(255),
    "marketPrice" DOUBLE PRECISION,
    "marketValue" DOUBLE PRECISION,
    "marketValueInOriginalCurrency" DOUBLE PRECISION,
    "marketValueOnSettlementDate" DOUBLE PRECISION,
    "maturityDate" DATE,
    "optionType" VARCHAR(255),
    "originalCurrencyCode" VARCHAR(255),
    "parValue" DOUBLE PRECISION,
    "priceDate" DATE,
    "purchaseAmount" DOUBLE PRECISION,
    "purchaseDate" DATE,
    "purchasePrice" DOUBLE PRECISION,
    "quantity" DOUBLE PRECISION,
    "sedol" VARCHAR(255),
    "strikePrice" DOUBLE PRECISION,
    "symbol" VARCHAR(255),
    "term" VARCHAR(255),
    "totalPremium" DOUBLE PRECISION,
    "totalQuantity" NUMERIC,
    "underlyingSymbol" VARCHAR(255),
    "underlyingSymbolPrice" DOUBLE PRECISION,
    "unitCost" DOUBLE PRECISION,
    "unrealizedGainLoss" DOUBLE PRECISION,
    "valoren" VARCHAR(255),
    "yieldToCall" DOUBLE PRECISION,
    "yieldToMaturity" DOUBLE PRECISION,
    "account_id" UUID,
    "security_id" UUID
);

-- Table: Product
CREATE TABLE "Product" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "category" VARCHAR(255),
    "code" VARCHAR(255),
    "description" VARCHAR(255),
    "image" VARCHAR(2096),
    "name" VARCHAR(255),
    "rating" VARCHAR(255),
    "subCategory" VARCHAR(255),
    "features_id" UUID,
    "productCategory_id" UUID,
    "provider_id" UUID
);

-- Table: ProductCategory
CREATE TABLE "ProductCategory" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "category" VARCHAR(255),
    "code" VARCHAR(255),
    "description" VARCHAR(255),
    "domain" VARCHAR(255),
    "image" VARCHAR(2096),
    "subDomain" VARCHAR(255)
);

-- Table: ProductFeatures
CREATE TABLE "ProductFeatures" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "feature_id" UUID
);

-- Table: ProductProvider
CREATE TABLE "ProductProvider" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code" VARCHAR(255),
    "description" VARCHAR(255),
    "image" VARCHAR(2096),
    "name" VARCHAR(255)
);

-- Table: ProofOfIdentity
CREATE TABLE "ProofOfIdentity" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "expiryDate" DATE,
    "idNumber" VARCHAR(255),
    "issueDate" DATE,
    "issuingStateOrProvince" VARCHAR(255),
    "type" VARCHAR(255),
    "document_id" UUID,
    "issuingCountry_id" UUID,
    "issuingState_id" UUID
);

-- Table: ReceivedFile
CREATE TABLE "ReceivedFile" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "fileName" VARCHAR(255),
    "j_Size" BIGINT,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "name" VARCHAR(255),
    "niGOFileName" VARCHAR(255),
    "rows" BIGINT,
    "expectedFile_id" UUID
);

-- Table: RecordSource
CREATE TABLE "RecordSource" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "name" VARCHAR(255),
    "priority" BIGINT
);

-- Table: RegistrationType
CREATE TABLE "RegistrationType" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "applicableTo" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "category" VARCHAR(255),
    "code" VARCHAR(255),
    "custodianCode" VARCHAR(255),
    "description" VARCHAR(255),
    "enabled" BOOLEAN,
    "image" VARCHAR(2096),
    "instructions" VARCHAR(2000),
    "isCoveredByERISA" BOOLEAN,
    "isRetirement" BOOLEAN,
    "name" VARCHAR(255),
    "sortOrder" BIGINT,
    "custodian_id" UUID
);

-- Table: RegistrationTypeGroup
CREATE TABLE "RegistrationTypeGroup" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" VARCHAR(255),
    "registrationTypes_id" UUID
);

-- Table: RegulatoryDisclosure
CREATE TABLE "RegulatoryDisclosure" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "affiliationType" VARCHAR(255),
    "enabled" BOOLEAN,
    "firmNameForEmployee" VARCHAR(255),
    "firmNameForOfficer" VARCHAR(255),
    "firmTickerForOfficer" VARCHAR(255),
    "foreignCountryName" VARCHAR(255),
    "nameOfEmployee" VARCHAR(255),
    "nameOfForeignOfficial" VARCHAR(255),
    "nameOfIndividual" VARCHAR(255),
    "officeHeldWithForeignGovt" VARCHAR(255),
    "relationshipOfEmployee" VARCHAR(255),
    "relationshipOfOfficer" VARCHAR(255),
    "typeOfEmployer" VARCHAR(255),
    "firmAddress_id" UUID,
    "foreignCountry_id" UUID,
    "regulatoryDisclosureOption_id" UUID
);

-- Table: RegulatoryDisclosureOption
CREATE TABLE "RegulatoryDisclosureOption" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "disclosureType" VARCHAR(255),
    "enabled" BOOLEAN,
    "label" VARCHAR(255)
);

-- Table: RegulatoryDisclosureV0
CREATE TABLE "RegulatoryDisclosureV0" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "directorOrOfficerInPublicCompany" BOOLEAN,
    "employedBySecurityIndustryEntity" BOOLEAN,
    "firmNameForEmployee" VARCHAR(255),
    "firmNameForOfficer" VARCHAR(255),
    "firmTickerForOfficer" VARCHAR(255),
    "foreignCountryName" VARCHAR(255),
    "nameOfEmployee" VARCHAR(255),
    "nameOfForeignOfficial" VARCHAR(255),
    "nameOfIndividual" VARCHAR(255),
    "officeHeldWithForeignGovt" VARCHAR(255),
    "officerRole" VARCHAR(255),
    "relationshipOfEmployee" VARCHAR(255),
    "relationshipOfOfficer" VARCHAR(255),
    "seniorMilitaryGovernmentOrPoliticalOffic" BOOLEAN,
    "typeOfEmployer" VARCHAR(255),
    "foreignCountry_id" UUID
);

-- Table: RelatedAccountResponse
CREATE TABLE "RelatedAccountResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountNumber" VARCHAR(255),
    "primaryAcctBranch" VARCHAR(255),
    "primaryAcctChangeDate" VARCHAR(255),
    "primaryAcctHomePhone" VARCHAR(255),
    "primaryAcctNameAddr1" VARCHAR(255),
    "primaryAcctNameAddr2" VARCHAR(255),
    "primaryAcctNameAddr3" VARCHAR(255),
    "primaryAcctNameAddr4" VARCHAR(255),
    "primaryAcctNameAddr5" VARCHAR(255),
    "primaryAcctRep" VARCHAR(255),
    "primaryAcctTaxId" VARCHAR(255),
    "sub" VARCHAR(255)
);

-- Table: RepCode
CREATE TABLE "RepCode" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "description" VARCHAR(255),
    "isSplit" BOOLEAN,
    "name" VARCHAR(255),
    "parentCode" VARCHAR(255),
    "repCode" VARCHAR(255),
    "repName" VARCHAR(255),
    "source" VARCHAR(255)
);

-- Table: RepCodeAccountBalances
CREATE TABLE "RepCodeAccountBalances" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "beginningAccounts" BIGINT,
    "beginningAssets" DOUBLE PRECISION,
    "beginningBuyingPower" DOUBLE PRECISION,
    "beginningCashBalance" DOUBLE PRECISION,
    "beginningMarginBalance" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "closedAccounts" BIGINT,
    "contributions" DOUBLE PRECISION,
    "endingAccounts" BIGINT,
    "endingAssets" DOUBLE PRECISION,
    "endingBuyingPower" DOUBLE PRECISION,
    "endingCashBalance" DOUBLE PRECISION,
    "endingMarginBalance" DOUBLE PRECISION,
    "marketAppreciation" DOUBLE PRECISION,
    "newAccounts" BIGINT,
    "periodEndDate" DATE,
    "periodStartDate" DATE,
    "periodType" VARCHAR(255),
    "withdrawals" DOUBLE PRECISION,
    "repCode_id" UUID
);

-- Table: RepCodeSplit
CREATE TABLE "RepCodeSplit" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "splitPercentage" DOUBLE PRECISION,
    "sourceRepCode_id" UUID,
    "targetRepCode_id" UUID
);

-- Table: RepPositions
CREATE TABLE "RepPositions" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "marketValue" DOUBLE PRECISION,
    "numberOfAccounts" BIGINT,
    "numberOfShares" BIGINT,
    "periodEndDate" DATE,
    "repCode_id" UUID,
    "security_id" UUID
);

-- Table: RequiredDocument
CREATE TABLE "RequiredDocument" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "documentTypeName" VARCHAR(255),
    "sendDocumentToAXOS" BOOLEAN
);

-- Table: RequriedDocumentsCriteria
CREATE TABLE "RequriedDocumentsCriteria" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "criteria" VARCHAR(255),
    "documentType_id" UUID,
    "fundingMethodInfo_id" UUID,
    "registrationTypeInfo_id" UUID
);

-- Table: ResourceFilterTypes
CREATE TABLE "ResourceFilterTypes" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "label" VARCHAR(255),
    "name" VARCHAR(255)
);

-- Table: RetirementGoal
CREATE TABLE "RetirementGoal" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "livingExpensesInRetirement" DOUBLE PRECISION,
    "mortgagePaidOffByRetirement" BOOLEAN,
    "retireWithSpouse" BOOLEAN,
    "retirementAge" BIGINT,
    "retirementLifestyle" VARCHAR(255)
);

-- Table: RetirementPlanSummary
CREATE TABLE "RetirementPlanSummary" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "corrected1099Status" VARCHAR(255),
    "corrected5498Status" VARCHAR(255),
    "correctedFMVStatementStatus" VARCHAR(255),
    "currentEndOfYearMarketValue" DOUBLE PRECISION,
    "distributionSource" VARCHAR(255),
    "eligibleForFeeDiscounts" BOOLEAN,
    "federalWithholdingPercentage" DOUBLE PRECISION,
    "feeSchedule" VARCHAR(255),
    "feesPaid" BOOLEAN,
    "isParticipantDeceased" BOOLEAN,
    "isPooledPlan" BOOLEAN,
    "isPrimary" BOOLEAN,
    "lastChangeDate" DATE,
    "lastChangeTerminal" VARCHAR(255),
    "lastChangedBy" VARCHAR(255),
    "overrideMarketValue" BOOLEAN,
    "planClass" VARCHAR(255),
    "previousEndOfYearMarketValue" DOUBLE PRECISION,
    "relatedAccountNumber" VARCHAR(255),
    "skipFees" BOOLEAN,
    "skipGenerating1099R" BOOLEAN,
    "skipGenerating5498" BOOLEAN,
    "skipGeneratingFMVStatement" BOOLEAN,
    "stateWithholdingPercentage" DOUBLE PRECISION,
    "terminationReason" VARCHAR(255),
    "account_id" UUID
);

-- Table: RoutingNumber
CREATE TABLE "RoutingNumber" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "routingNumber" VARCHAR(255),
    "state_id" UUID
);

-- Table: SecuritiesTransferSecurity
CREATE TABLE "SecuritiesTransferSecurity" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "amount" DOUBLE PRECISION,
    "capitalGainsOption" VARCHAR(255),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "cusip" VARCHAR(255),
    "description" VARCHAR(255),
    "dividendOption" VARCHAR(255),
    "fundAccountNumber" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "mutualFundTransferOption" VARCHAR(255),
    "quantity" NUMERIC,
    "symbol" VARCHAR(255),
    "transferAll" BOOLEAN,
    "transferUnits" VARCHAR(255)
);

-- Table: SecuritiesTransferSourceOrReceiver
CREATE TABLE "SecuritiesTransferSourceOrReceiver" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountHolderAlternateName" VARCHAR(255),
    "accountNumber" VARCHAR(255),
    "accountTitle" VARCHAR(255),
    "additionalInformation" VARCHAR(255),
    "clearingNumber" VARCHAR(255),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "deliveringAccountTitleSameAsReceiving" BOOLEAN,
    "deliveryMethod" VARCHAR(255),
    "firmName" VARCHAR(255),
    "firmPhoneNumber" VARCHAR(50),
    "intermediaryBank" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "payeeAddressType" VARCHAR(255),
    "payeeIsSender" BOOLEAN,
    "payeeName" VARCHAR(255),
    "payeePhoneNumber" VARCHAR(50),
    "payeeRelationshipType" VARCHAR(255),
    "accountOwners_id" UUID,
    "firmAddress_id" UUID,
    "payeeAddress_id" UUID,
    "registrationType_id" UUID
);

-- Table: Security
CREATE TABLE "Security" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "assetClass" VARCHAR(255),
    "bondClass" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "callIndicator" VARCHAR(255),
    "closedEnd" BOOLEAN,
    "closedToBuys" BOOLEAN,
    "closedToNewInvestors" BOOLEAN,
    "closedToSells" BOOLEAN,
    "countryCode" VARCHAR(255),
    "couponRate" DOUBLE PRECISION,
    "cusip" VARCHAR(255),
    "custodianAssignedID" VARCHAR(255),
    "dividendFrequency" VARCHAR(255),
    "dividendOrInterestPaymentMethod" VARCHAR(255),
    "dividendReinvestEligible" BOOLEAN,
    "dividendYield" DOUBLE PRECISION,
    "dtCCEligible" BOOLEAN,
    "endOfMonthPrice" DOUBLE PRECISION,
    "endOfMonthPriceDate" DATE,
    "etFIndicator" BOOLEAN,
    "exchange" VARCHAR(255),
    "expenseRatio" DOUBLE PRECISION,
    "factorDate" DATE,
    "foreignSecurityIndicator" BOOLEAN,
    "fundFamilyCode" VARCHAR(255),
    "fundFamilyName" VARCHAR(255),
    "fundServIndicator" BOOLEAN,
    "fundShareClass" VARCHAR(255),
    "fundType" VARCHAR(255),
    "fundVestIndicator" BOOLEAN,
    "interestCalculation" VARCHAR(255),
    "interestFrequency" VARCHAR(255),
    "isVariableRate" BOOLEAN,
    "isin" VARCHAR(255),
    "issuer" VARCHAR(255),
    "issuingCurrency" VARCHAR(255),
    "lastPrice" DOUBLE PRECISION,
    "lastPriceDate" DATE,
    "leveragedPercentage" DOUBLE PRECISION,
    "maturityOrExpirationDate" DATE,
    "minorProductCode" VARCHAR(255),
    "moodysBondRating" VARCHAR(255),
    "optionExpiryDate" DATE,
    "paymentDelayDays" VARCHAR(255),
    "poolFactor" DOUBLE PRECISION,
    "previousDayPrice" DOUBLE PRECISION,
    "previousFactor" DOUBLE PRECISION,
    "previousFactorDate" DATE,
    "previousPriceDate" DATE,
    "productCodeName" VARCHAR(255),
    "recordSource" VARCHAR(255),
    "reinvestCapitalGains" BOOLEAN,
    "reinvestDividends" BOOLEAN,
    "securityCalculationCode" VARCHAR(255),
    "securityDescription1" VARCHAR(255),
    "securityDescription2" VARCHAR(255),
    "securityDescription3" VARCHAR(255),
    "securityDescription4" VARCHAR(255),
    "securityDescription5" VARCHAR(255),
    "securityDescription6" VARCHAR(255),
    "securityModifier" VARCHAR(255),
    "sedol" VARCHAR(255),
    "siCCode" VARCHAR(255),
    "strikePrice" DOUBLE PRECISION,
    "structuredProductIndicator" BOOLEAN,
    "symbol" VARCHAR(255),
    "underlyingSecurityNumber" VARCHAR(255),
    "valoren" VARCHAR(255),
    "worthlessSecurityIndicator" BOOLEAN,
    "product_id" UUID,
    "securityType_id" UUID
);

-- Table: SecurityRestriction
CREATE TABLE "SecurityRestriction" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "dateAdded" DATE,
    "errorLevel" VARCHAR(255),
    "restriction" VARCHAR(255),
    "security_id" UUID
);

-- Table: SecurityType
CREATE TABLE "SecurityType" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "category" VARCHAR(255),
    "code" VARCHAR(255),
    "custodianCode" VARCHAR(255),
    "description" VARCHAR(255),
    "name" VARCHAR(255),
    "custodian_id" UUID
);

-- Table: SecurityTypeCustodianMapping
CREATE TABLE "SecurityTypeCustodianMapping" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code" VARCHAR(255),
    "name" VARCHAR(255),
    "custodian_id" UUID,
    "securityType_id" UUID
);

-- Table: Signature
CREATE TABLE "Signature" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "role" VARCHAR(255),
    "routingOrder" BIGINT,
    "signatory" VARCHAR(255),
    "status" VARCHAR(255)
);

-- Table: SrAdditionalInfo
CREATE TABLE "SrAdditionalInfo" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "info1" VARCHAR(255),
    "info10" VARCHAR(255),
    "info11" VARCHAR(255),
    "info12" VARCHAR(255),
    "info13" VARCHAR(255),
    "info14" VARCHAR(255),
    "info15" VARCHAR(255),
    "info2" VARCHAR(255),
    "info3" VARCHAR(5000),
    "info4" VARCHAR(255),
    "info5" VARCHAR(255),
    "info6" VARCHAR(255),
    "info7" VARCHAR(255),
    "info8" VARCHAR(255),
    "info9" VARCHAR(255)
);

-- Table: SrCategory
CREATE TABLE "SrCategory" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "name" VARCHAR(255),
    "rank" BIGINT,
    "subCategory_id" UUID
);

-- Table: SrDefinition
CREATE TABLE "SrDefinition" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "description" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "name" VARCHAR(255),
    "priority" VARCHAR(255),
    "rootBusinessObject" VARCHAR(255),
    "storyID" VARCHAR(255),
    "validationRule" VARCHAR(255),
    "workflowDefID" VARCHAR(255),
    "category_id" UUID,
    "mergeReadQuery_id" UUID,
    "subCategory_id" UUID,
    "tasks_id" UUID
);

-- Table: SrInstance
CREATE TABLE "SrInstance" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountID" VARCHAR(255),
    "accountNumber" VARCHAR(255),
    "advisorID" VARCHAR(255),
    "afterCommit" VARCHAR(200000),
    "beforeCommit" VARCHAR(200000),
    "boInstanceID" VARCHAR(255),
    "clientID" VARCHAR(255),
    "clientName" VARCHAR(255),
    "closedAt" TIMESTAMP WITH TIME ZONE,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "filterValue" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "repCode" VARCHAR(255),
    "sparseObject" VARCHAR(100000),
    "srNumber" TEXT,
    "workflowID" VARCHAR(255),
    "additionalInfo_id" UUID,
    "currentTask_id" UUID,
    "documents_id" UUID,
    "notes_id" UUID,
    "srDef_id" UUID,
    "tasks_id" UUID
);

-- Table: SrNote
CREATE TABLE "SrNote" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "documents" VARCHAR(2096),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "note" VARCHAR(255)
);

-- Table: SrQuery
CREATE TABLE "SrQuery" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "domain" VARCHAR(255),
    "domainName" VARCHAR(255),
    "entityID" VARCHAR(255),
    "entityLabel" VARCHAR(255),
    "entityName" VARCHAR(255),
    "operationID" VARCHAR(255),
    "queryName" VARCHAR(255),
    "queryText" VARCHAR(200000),
    "serviceID" VARCHAR(255)
);

-- Table: SrStateDef
CREATE TABLE "SrStateDef" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "isFinal" BOOLEAN,
    "isStart" BOOLEAN,
    "name" VARCHAR(255),
    "stateId" VARCHAR(255)
);

-- Table: SrStatus
CREATE TABLE "SrStatus" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "status_id" UUID
);

-- Table: SrStatusCode
CREATE TABLE "SrStatusCode" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "isFinal" BOOLEAN,
    "isStart" BOOLEAN,
    "name" VARCHAR(255),
    "stateId" VARCHAR(255)
);

-- Table: SrSubCategory
CREATE TABLE "SrSubCategory" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "name" VARCHAR(255),
    "rank" BIGINT
);

-- Table: SrTask
CREATE TABLE "SrTask" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "actualTime" TIMESTAMP WITH TIME ZONE,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "esignatureEnvelopeID" VARCHAR(255),
    "estimatedTime" TIMESTAMP WITH TIME ZONE,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "response" VARCHAR(10000),
    "sequenceID" TEXT,
    "signalID" VARCHAR(255),
    "taskDefID" VARCHAR(255),
    "workflowID" VARCHAR(255),
    "assignedTo_id" UUID,
    "currentStatus_id" UUID,
    "signatures_id" UUID,
    "status_id" UUID
);

-- Table: SrTaskDef
CREATE TABLE "SrTaskDef" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" VARCHAR(255),
    "taskId" VARCHAR(255),
    "status_id" UUID
);

-- Table: SrWorkflowArgs
CREATE TABLE "SrWorkflowArgs" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "assignTo" VARCHAR(255),
    "boInstanceID" VARCHAR(255),
    "data" VARCHAR(255),
    "isCompleted" BOOLEAN,
    "preview" BOOLEAN,
    "srDefID" VARCHAR(255),
    "srInstanceID" VARCHAR(255),
    "taskStatus" VARCHAR(255),
    "validate" BOOLEAN,
    "errors_id" UUID
);

-- Table: StandingInstructionsResponse
CREATE TABLE "StandingInstructionsResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bankAccountNumber" VARCHAR(255),
    "bankAccountOwnersName" VARCHAR(255),
    "bankAccountType" VARCHAR(255),
    "bankName" VARCHAR(255),
    "bankRoutingNumber" VARCHAR(255),
    "instructionStatus" VARCHAR(255)
);

-- Table: StateOrProvince
CREATE TABLE "StateOrProvince" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "code" VARCHAR(255),
    "name" VARCHAR(255),
    "country_id" UUID
);

-- Table: StepVisibilityCriteria
CREATE TABLE "StepVisibilityCriteria" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "custodian" VARCHAR(255),
    "registrationGroup_id" UUID,
    "step_id" UUID
);

-- Table: SupportedRegistrationTypes
CREATE TABLE "SupportedRegistrationTypes" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "code" VARCHAR(255),
    "isAvailable" BOOLEAN
);

-- Table: SupportingDocuments
CREATE TABLE "SupportingDocuments" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "clientName" VARCHAR(255),
    "documentTypeName" VARCHAR(255),
    "registrationTypeInfo_id" UUID
);

-- Table: Task
CREATE TABLE "Task" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "createdBy" VARCHAR(255),
    "elapsedDays" BIGINT,
    "lastModifiedAt" TIMESTAMP WITH TIME ZONE,
    "lastModifiedBy" VARCHAR(255),
    "priority" BIGINT,
    "repCode" VARCHAR(255),
    "status" VARCHAR(255),
    "statusMessage" VARCHAR(255),
    "account_id" UUID,
    "assignedTo_id" UUID
);

-- Table: TaxLot
CREATE TABLE "TaxLot" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "asOfDate" DATE,
    "blendedUnitCost" DOUBLE PRECISION,
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "closedDate" DATE,
    "cusip" VARCHAR(255),
    "custodianAssignedSecurityID" VARCHAR(255),
    "description" VARCHAR(255),
    "held" VARCHAR(255),
    "isClosed" BOOLEAN,
    "isin" VARCHAR(255),
    "longTermRealizedGainOrLoss" DOUBLE PRECISION,
    "longTermUnrealizedGainOrLoss" DOUBLE PRECISION,
    "marketPrice" DOUBLE PRECISION,
    "marketValue" DOUBLE PRECISION,
    "openDate" DATE,
    "quantity" DOUBLE PRECISION,
    "sedol" VARCHAR(255),
    "shortTermRealizedGainOrLoss" DOUBLE PRECISION,
    "shortTermUnrealizedGainOrLoss" DOUBLE PRECISION,
    "symbol" VARCHAR(255),
    "taxLotID" VARCHAR(255),
    "term" VARCHAR(255),
    "totalCost" DOUBLE PRECISION,
    "totalRealizedGainOrLoss" DOUBLE PRECISION,
    "totalUnrealizedGainOrLoss" DOUBLE PRECISION,
    "tradePrice" DOUBLE PRECISION,
    "valoren" VARCHAR(255),
    "account_id" UUID,
    "currency_id" UUID,
    "security_id" UUID
);

-- Table: Templatedemail
CREATE TABLE "Templatedemail" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "attachments" TEXT,
    "data" TEXT,
    "providerName" TEXT,
    "templatePath" TEXT
);

-- Table: Transfer
CREATE TABLE "Transfer" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "accountHolderMeetsAgeRequirement" BOOLEAN,
    "amount" DOUBLE PRECISION,
    "bankAccountTransferType" VARCHAR(255),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "cdMaturityDate" DATE,
    "closeAccount" BOOLEAN,
    "contributionYear" VARCHAR(255),
    "costBasisStepUp" BOOLEAN,
    "createdAt" TIMESTAMP WITH TIME ZONE,
    "dateOfDeath" DATE,
    "detailsToBeProvided" BOOLEAN,
    "distributeSecurities" BOOLEAN,
    "excessContributionAmount" DOUBLE PRECISION,
    "excessContributionDate" DATE,
    "excessContributionEarnings" DOUBLE PRECISION,
    "federalWithholdingAmount" DOUBLE PRECISION,
    "federalWithholdingPercent" DOUBLE PRECISION,
    "frequency" VARCHAR(255),
    "internalTransferAssetTypeOptions" VARCHAR(255),
    "internalTransferType" VARCHAR(255),
    "irADistributionAmount" VARCHAR(255),
    "irADistributionFrequency" VARCHAR(255),
    "irADistributionReason" VARCHAR(255),
    "isForProductPurchase" BOOLEAN,
    "isIRAContribution" BOOLEAN,
    "isPriorYearExcessContribution" BOOLEAN,
    "isRolloverWithin60Days" BOOLEAN,
    "isThirdParty" BOOLEAN,
    "lastModifiedBy" VARCHAR(255),
    "memo" VARCHAR(2000),
    "netAttributableIncome" DOUBLE PRECISION,
    "notes" VARCHAR(2000),
    "optOutOfStateWithholding" BOOLEAN,
    "ownerAddressType" VARCHAR(255),
    "partialTransferAmount" DOUBLE PRECISION,
    "partialTransferPercent" DOUBLE PRECISION,
    "reCharacterizationYear" VARCHAR(255),
    "replaceExistingInstruction" BOOLEAN,
    "requestSource" VARCHAR(255),
    "rolloverQuantityChoice" VARCHAR(255),
    "rothIRA5YearRequirementMet" BOOLEAN,
    "securitiesTransferType" VARCHAR(255),
    "siMPLEIRAOriginalFundingDate" DATE,
    "specialDelivery" VARCHAR(255),
    "srId" VARCHAR(255),
    "standingInstruction" BOOLEAN,
    "startDate" DATE,
    "stateWithholdingAmount" DOUBLE PRECISION,
    "stateWithholdingOption" VARCHAR(255),
    "stateWithholdingPercent" DOUBLE PRECISION,
    "stateWithholdingPercentOfFederal" DOUBLE PRECISION,
    "status" VARCHAR(255),
    "taxYear" BIGINT,
    "transferType" VARCHAR(255),
    "typeOfFunds" VARCHAR(255),
    "withholdingType" VARCHAR(255),
    "bankAccount_id" UUID,
    "otherAccount_id" UUID,
    "securities_id" UUID,
    "sender_id" UUID,
    "taxFilingState_id" UUID
);

-- Table: TransferStatusResponse
CREATE TABLE "TransferStatusResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "messages" VARCHAR(2000),
    "requestId" VARCHAR(255),
    "sequence" VARCHAR(255),
    "status" VARCHAR(255),
    "timestamp" TIMESTAMP WITH TIME ZONE
);

-- Table: UiToggleFields
CREATE TABLE "UiToggleFields" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "clientSelection" VARCHAR(255),
    "summaryView" VARCHAR(255)
);

-- Table: UserRepCodeMapping
CREATE TABLE "UserRepCodeMapping" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "bulkLoadRecIdJfyApx" TEXT,
    "bulkLoadRunIdJfyApx" TEXT,
    "repCode" TEXT,
    "userId" VARCHAR(255)
);

-- Table: ValidationConfig
CREATE TABLE "ValidationConfig" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "enabled" BOOLEAN,
    "override" BOOLEAN,
    "rule_id" UUID
);

-- Table: ValidationRule
CREATE TABLE "ValidationRule" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "description" VARCHAR(255),
    "name" VARCHAR(255),
    "ruleset" VARCHAR(255)
);

-- Table: WireCreateResponse
CREATE TABLE "WireCreateResponse" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "requestId" VARCHAR(255)
);

-- Table: WizardForm
CREATE TABLE "WizardForm" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "custodianName" VARCHAR(255),
    "docCategory" VARCHAR(255),
    "docTypeName" VARCHAR(255),
    "firmName" VARCHAR(255)
);

-- Table: WizardStep
CREATE TABLE "WizardStep" (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "custodianName" VARCHAR(255),
    "regTypeName" VARCHAR(255),
    "stepName" VARCHAR(255)
);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_accountCommunicationPreferences" 
FOREIGN KEY ("accountCommunicationPreferences_id") REFERENCES "AccountCommunicationPreference"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_accountCreationDetail" 
FOREIGN KEY ("accountCreationDetail_id") REFERENCES "AccountCreationDetail"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_accountFeatures" 
FOREIGN KEY ("accountFeatures_id") REFERENCES "AccountFeatures"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_annuityDetails" 
FOREIGN KEY ("annuityDetails_id") REFERENCES "AnnuityDetails"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_assets" 
FOREIGN KEY ("assets_id") REFERENCES "Assets"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_associates" 
FOREIGN KEY ("associates_id") REFERENCES "AccountAssociate"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_beneficiaries" 
FOREIGN KEY ("beneficiaries_id") REFERENCES "Beneficiary"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_branch" 
FOREIGN KEY ("branch_id") REFERENCES "Branch"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_client" 
FOREIGN KEY ("client_id") REFERENCES "Client"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_collateral" 
FOREIGN KEY ("collateral_id") REFERENCES "Collateral"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_contingentBeneficiaries" 
FOREIGN KEY ("contingentBeneficiaries_id") REFERENCES "Beneficiary"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_custodian" 
FOREIGN KEY ("custodian_id") REFERENCES "Custodian"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_custodianForMinor" 
FOREIGN KEY ("custodianForMinor_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_dailyBalances" 
FOREIGN KEY ("dailyBalances_id") REFERENCES "AccountBalances"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_documents" 
FOREIGN KEY ("documents_id") REFERENCES "Document"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_employerContact" 
FOREIGN KEY ("employerContact_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_feeSchedule" 
FOREIGN KEY ("feeSchedule_id") REFERENCES "FeeSchedule"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_governingStateLawForCustodialAccount" 
FOREIGN KEY ("governingStateLawForCustodialAccount_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_holdings" 
FOREIGN KEY ("holdings_id") REFERENCES "Holdings"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_interestedParties" 
FOREIGN KEY ("interestedParties_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_intraDayBalances" 
FOREIGN KEY ("intraDayBalances_id") REFERENCES "AccountBalances"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_irADistributionInstructions" 
FOREIGN KEY ("irADistributionInstructions_id") REFERENCES "Transfer"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_irAFinancialInstitution" 
FOREIGN KEY ("irAFinancialInstitution_id") REFERENCES "FinancialInstitution"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_jointTenancyState" 
FOREIGN KEY ("jointTenancyState_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_liabilities" 
FOREIGN KEY ("liabilities_id") REFERENCES "Liabilities"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_marginRates" 
FOREIGN KEY ("marginRates_id") REFERENCES "MarginRates"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_notices" 
FOREIGN KEY ("notices_id") REFERENCES "AccountNotice"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_originalDepositor" 
FOREIGN KEY ("originalDepositor_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel0" 
FOREIGN KEY ("ouLevel0_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel1" 
FOREIGN KEY ("ouLevel1_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel2" 
FOREIGN KEY ("ouLevel2_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel3" 
FOREIGN KEY ("ouLevel3_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel4" 
FOREIGN KEY ("ouLevel4_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel5" 
FOREIGN KEY ("ouLevel5_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_ouLevel6" 
FOREIGN KEY ("ouLevel6_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_precedingOwner" 
FOREIGN KEY ("precedingOwner_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_primaryOwner" 
FOREIGN KEY ("primaryOwner_id") REFERENCES "AccountOwnership"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_registrationType" 
FOREIGN KEY ("registrationType_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_regulatoryDisclosures" 
FOREIGN KEY ("regulatoryDisclosures_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_relatedAccounts" 
FOREIGN KEY ("relatedAccounts_id") REFERENCES "AccountRelation"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_repCodeLink" 
FOREIGN KEY ("repCodeLink_id") REFERENCES "RepCode"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_responsibleIndividualForMaintainingStirp" 
FOREIGN KEY ("responsibleIndividualForMaintainingStirp_id") REFERENCES "AccountInterestedParties"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_secondaryOwners" 
FOREIGN KEY ("secondaryOwners_id") REFERENCES "AccountOwnership"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_statementSchedule" 
FOREIGN KEY ("statementSchedule_id") REFERENCES "AccountStatementSchedule"(id);

ALTER TABLE "Account" 
ADD CONSTRAINT "fk_Account_transfers" 
FOREIGN KEY ("transfers_id") REFERENCES "Transfer"(id);

ALTER TABLE "AccountAssociate" 
ADD CONSTRAINT "fk_AccountAssociate_associate" 
FOREIGN KEY ("associate_id") REFERENCES "Associate"(id);

ALTER TABLE "AccountBalances" 
ADD CONSTRAINT "fk_AccountBalances_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "AccountBalances" 
ADD CONSTRAINT "fk_AccountBalances_cashAccountSymbol" 
FOREIGN KEY ("cashAccountSymbol_id") REFERENCES "Security"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_accountType" 
FOREIGN KEY ("accountType_id") REFERENCES "Category"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_documents" 
FOREIGN KEY ("documents_id") REFERENCES "Document"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_primaryOwner" 
FOREIGN KEY ("primaryOwner_id") REFERENCES "Person"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_productCategory" 
FOREIGN KEY ("productCategory_id") REFERENCES "ProductCategory"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_registrationType" 
FOREIGN KEY ("registrationType_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_repCode" 
FOREIGN KEY ("repCode_id") REFERENCES "RepCode"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_secondaryOwners" 
FOREIGN KEY ("secondaryOwners_id") REFERENCES "Person"(id);

ALTER TABLE "AccountBuilder" 
ADD CONSTRAINT "fk_AccountBuilder_secondaryOwnersV2" 
FOREIGN KEY ("secondaryOwnersV2_id") REFERENCES "Person"(id);

ALTER TABLE "AccountCreation" 
ADD CONSTRAINT "fk_AccountCreation_category" 
FOREIGN KEY ("category_id") REFERENCES "Category"(id);

ALTER TABLE "AccountCreation" 
ADD CONSTRAINT "fk_AccountCreation_primaryOwner" 
FOREIGN KEY ("primaryOwner_id") REFERENCES "Person"(id);

ALTER TABLE "AccountCreation" 
ADD CONSTRAINT "fk_AccountCreation_registrationType" 
FOREIGN KEY ("registrationType_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "AccountCreation" 
ADD CONSTRAINT "fk_AccountCreation_secondaryOwners" 
FOREIGN KEY ("secondaryOwners_id") REFERENCES "Person"(id);

ALTER TABLE "AccountCreationDetail" 
ADD CONSTRAINT "fk_AccountCreationDetail_documents" 
FOREIGN KEY ("documents_id") REFERENCES "Document"(id);

ALTER TABLE "AccountCreationDetail" 
ADD CONSTRAINT "fk_AccountCreationDetail_initialFundingCurrency" 
FOREIGN KEY ("initialFundingCurrency_id") REFERENCES "Currency"(id);

ALTER TABLE "AccountCreationDetail" 
ADD CONSTRAINT "fk_AccountCreationDetail_onlineAccountSetup" 
FOREIGN KEY ("onlineAccountSetup_id") REFERENCES "OnlineAccountSetup"(id);

ALTER TABLE "AccountCreationDetail" 
ADD CONSTRAINT "fk_AccountCreationDetail_signatures" 
FOREIGN KEY ("signatures_id") REFERENCES "Signature"(id);

ALTER TABLE "AccountCreationDetail" 
ADD CONSTRAINT "fk_AccountCreationDetail_sourceOfFunds" 
FOREIGN KEY ("sourceOfFunds_id") REFERENCES "AccountSourceOfFunds"(id);

ALTER TABLE "AccountDataMapper" 
ADD CONSTRAINT "fk_AccountDataMapper_steps" 
FOREIGN KEY ("steps_id") REFERENCES "AccountCreationStep"(id);

ALTER TABLE "AccountDueDiligenceOptions" 
ADD CONSTRAINT "fk_AccountDueDiligenceOptions_expectedFundingMethod" 
FOREIGN KEY ("expectedFundingMethod_id") REFERENCES "FundingMethodTypes"(id);

ALTER TABLE "AccountFeatures" 
ADD CONSTRAINT "fk_AccountFeatures_owner" 
FOREIGN KEY ("owner_id") REFERENCES "Person"(id);

ALTER TABLE "AccountFeatures" 
ADD CONSTRAINT "fk_AccountFeatures_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "AccountInterestedParties" 
ADD CONSTRAINT "fk_AccountInterestedParties_party" 
FOREIGN KEY ("party_id") REFERENCES "Person"(id);

ALTER TABLE "AccountMessages" 
ADD CONSTRAINT "fk_AccountMessages_parentId" 
FOREIGN KEY ("parentId_id") REFERENCES "Account"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_alternateMailingAddress" 
FOREIGN KEY ("alternateMailingAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_dueDiligenceOptions" 
FOREIGN KEY ("dueDiligenceOptions_id") REFERENCES "AccountDueDiligenceOptions"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_legalAddress" 
FOREIGN KEY ("legalAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_mailingAddress" 
FOREIGN KEY ("mailingAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_owner" 
FOREIGN KEY ("owner_id") REFERENCES "Person"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_previousLegalAddress" 
FOREIGN KEY ("previousLegalAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountOwnership" 
ADD CONSTRAINT "fk_AccountOwnership_trustedContact" 
FOREIGN KEY ("trustedContact_id") REFERENCES "Person"(id);

ALTER TABLE "AccountRelation" 
ADD CONSTRAINT "fk_AccountRelation_linkedAccounts" 
FOREIGN KEY ("linkedAccounts_id") REFERENCES "Account"(id);

ALTER TABLE "AccountSourceOfFunds" 
ADD CONSTRAINT "fk_AccountSourceOfFunds_bankAddress" 
FOREIGN KEY ("bankAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountSourceOfFunds" 
ADD CONSTRAINT "fk_AccountSourceOfFunds_fundingMethod" 
FOREIGN KEY ("fundingMethod_id") REFERENCES "FundingMethodTypes"(id);

ALTER TABLE "AccountSourceOfFunds" 
ADD CONSTRAINT "fk_AccountSourceOfFunds_intermediaryBankAddress" 
FOREIGN KEY ("intermediaryBankAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountSourceOfFunds" 
ADD CONSTRAINT "fk_AccountSourceOfFunds_payeeAddress" 
FOREIGN KEY ("payeeAddress_id") REFERENCES "Address"(id);

ALTER TABLE "AccountSourceOfFunds" 
ADD CONSTRAINT "fk_AccountSourceOfFunds_transfer" 
FOREIGN KEY ("transfer_id") REFERENCES "Transfer"(id);

ALTER TABLE "Address" 
ADD CONSTRAINT "fk_Address_country" 
FOREIGN KEY ("country_id") REFERENCES "Country"(id);

ALTER TABLE "Address" 
ADD CONSTRAINT "fk_Address_state" 
FOREIGN KEY ("state_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "AdvisorAccountBalances" 
ADD CONSTRAINT "fk_AdvisorAccountBalances_advisor" 
FOREIGN KEY ("advisor_id") REFERENCES "Associate"(id);

ALTER TABLE "AdvisorPositions" 
ADD CONSTRAINT "fk_AdvisorPositions_advisor" 
FOREIGN KEY ("advisor_id") REFERENCES "Associate"(id);

ALTER TABLE "AdvisorPositions" 
ADD CONSTRAINT "fk_AdvisorPositions_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "AggregatePositions" 
ADD CONSTRAINT "fk_AggregatePositions_advisor" 
FOREIGN KEY ("advisor_id") REFERENCES "Associate"(id);

ALTER TABLE "AggregatePositions" 
ADD CONSTRAINT "fk_AggregatePositions_client" 
FOREIGN KEY ("client_id") REFERENCES "Client"(id);

ALTER TABLE "AggregatePositions" 
ADD CONSTRAINT "fk_AggregatePositions_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "AggregatePositions" 
ADD CONSTRAINT "fk_AggregatePositions_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "Announcement" 
ADD CONSTRAINT "fk_Announcement_files" 
FOREIGN KEY ("files_id") REFERENCES "Document"(id);

ALTER TABLE "Announcement" 
ADD CONSTRAINT "fk_Announcement_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "AnnuityDetails" 
ADD CONSTRAINT "fk_AnnuityDetails_creditingStrategies" 
FOREIGN KEY ("creditingStrategies_id") REFERENCES "IndexedAnnuityCreditingStrategy"(id);

ALTER TABLE "AnnuityDetails" 
ADD CONSTRAINT "fk_AnnuityDetails_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "AnnuityDetails" 
ADD CONSTRAINT "fk_AnnuityDetails_riders" 
FOREIGN KEY ("riders_id") REFERENCES "Product"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_address" 
FOREIGN KEY ("address_id") REFERENCES "Address"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_canAccessOrgUnits" 
FOREIGN KEY ("canAccessOrgUnits_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_canAccessOrgUnitsAtOrBelow" 
FOREIGN KEY ("canAccessOrgUnitsAtOrBelow_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel0" 
FOREIGN KEY ("ouLevel0_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel1" 
FOREIGN KEY ("ouLevel1_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel2" 
FOREIGN KEY ("ouLevel2_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel3" 
FOREIGN KEY ("ouLevel3_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel4" 
FOREIGN KEY ("ouLevel4_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel5" 
FOREIGN KEY ("ouLevel5_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_ouLevel6" 
FOREIGN KEY ("ouLevel6_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Associate" 
ADD CONSTRAINT "fk_Associate_repCodes" 
FOREIGN KEY ("repCodes_id") REFERENCES "RepCode"(id);

ALTER TABLE "BalancesResponse" 
ADD CONSTRAINT "fk_BalancesResponse_balances" 
FOREIGN KEY ("balances_id") REFERENCES "AccountBalances"(id);

ALTER TABLE "BalancesResponse" 
ADD CONSTRAINT "fk_BalancesResponse_positions" 
FOREIGN KEY ("positions_id") REFERENCES "Position"(id);

ALTER TABLE "Beneficiary" 
ADD CONSTRAINT "fk_Beneficiary_beneficiary" 
FOREIGN KEY ("beneficiary_id") REFERENCES "Person"(id);

ALTER TABLE "Beneficiary" 
ADD CONSTRAINT "fk_Beneficiary_trustedContact" 
FOREIGN KEY ("trustedContact_id") REFERENCES "Person"(id);

ALTER TABLE "Branch" 
ADD CONSTRAINT "fk_Branch_address" 
FOREIGN KEY ("address_id") REFERENCES "Address"(id);

ALTER TABLE "Branch" 
ADD CONSTRAINT "fk_Branch_branchManager" 
FOREIGN KEY ("branchManager_id") REFERENCES "Associate"(id);

ALTER TABLE "Branch" 
ADD CONSTRAINT "fk_Branch_organizationalUnit" 
FOREIGN KEY ("organizationalUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "Branch" 
ADD CONSTRAINT "fk_Branch_parent" 
FOREIGN KEY ("parent_id") REFERENCES "FinancialInstitution"(id);

ALTER TABLE "CashFlow" 
ADD CONSTRAINT "fk_CashFlow_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "Client" 
ADD CONSTRAINT "fk_Client_additionalMembers" 
FOREIGN KEY ("additionalMembers_id") REFERENCES "Person"(id);

ALTER TABLE "Client" 
ADD CONSTRAINT "fk_Client_financialGoals" 
FOREIGN KEY ("financialGoals_id") REFERENCES "FinancialGoal"(id);

ALTER TABLE "Client" 
ADD CONSTRAINT "fk_Client_investmentGoals" 
FOREIGN KEY ("investmentGoals_id") REFERENCES "FinancialGoal"(id);

ALTER TABLE "Client" 
ADD CONSTRAINT "fk_Client_primaryMember" 
FOREIGN KEY ("primaryMember_id") REFERENCES "Person"(id);

ALTER TABLE "ClientAccountBalances" 
ADD CONSTRAINT "fk_ClientAccountBalances_advisor" 
FOREIGN KEY ("advisor_id") REFERENCES "Associate"(id);

ALTER TABLE "ClientAccountBalances" 
ADD CONSTRAINT "fk_ClientAccountBalances_client" 
FOREIGN KEY ("client_id") REFERENCES "Client"(id);

ALTER TABLE "ClientMember" 
ADD CONSTRAINT "fk_ClientMember_member" 
FOREIGN KEY ("member_id") REFERENCES "Person"(id);

ALTER TABLE "ClientPositions" 
ADD CONSTRAINT "fk_ClientPositions_advisor" 
FOREIGN KEY ("advisor_id") REFERENCES "Associate"(id);

ALTER TABLE "ClientPositions" 
ADD CONSTRAINT "fk_ClientPositions_client" 
FOREIGN KEY ("client_id") REFERENCES "Client"(id);

ALTER TABLE "ClientPositions" 
ADD CONSTRAINT "fk_ClientPositions_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "Collateral" 
ADD CONSTRAINT "fk_Collateral_loan" 
FOREIGN KEY ("loan_id") REFERENCES "Account"(id);

ALTER TABLE "Commissions" 
ADD CONSTRAINT "fk_Commissions_associate" 
FOREIGN KEY ("associate_id") REFERENCES "Associate"(id);

ALTER TABLE "Commissions" 
ADD CONSTRAINT "fk_Commissions_commissionsByProduct" 
FOREIGN KEY ("commissionsByProduct_id") REFERENCES "CommissionsByProduct"(id);

ALTER TABLE "Commissions" 
ADD CONSTRAINT "fk_Commissions_exchange" 
FOREIGN KEY ("exchange_id") REFERENCES "Exchange"(id);

ALTER TABLE "Commissions" 
ADD CONSTRAINT "fk_Commissions_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "CommissionsByProduct" 
ADD CONSTRAINT "fk_CommissionsByProduct_exchange" 
FOREIGN KEY ("exchange_id") REFERENCES "Exchange"(id);

ALTER TABLE "CommissionsByProduct" 
ADD CONSTRAINT "fk_CommissionsByProduct_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "EsignatureEnvelope" 
ADD CONSTRAINT "fk_EsignatureEnvelope_documents" 
FOREIGN KEY ("documents_id") REFERENCES "Document"(id);

ALTER TABLE "ExecutionHistory" 
ADD CONSTRAINT "fk_ExecutionHistory_inputFiles" 
FOREIGN KEY ("inputFiles_id") REFERENCES "ReceivedFile"(id);

ALTER TABLE "ExecutionHistory" 
ADD CONSTRAINT "fk_ExecutionHistory_outputFiles" 
FOREIGN KEY ("outputFiles_id") REFERENCES "OutputFile"(id);

ALTER TABLE "ExecutionHistory" 
ADD CONSTRAINT "fk_ExecutionHistory_steps" 
FOREIGN KEY ("steps_id") REFERENCES "ExecutionHistoryStep"(id);

ALTER TABLE "ExecutionHistoryStep" 
ADD CONSTRAINT "fk_ExecutionHistoryStep_expectedFiles" 
FOREIGN KEY ("expectedFiles_id") REFERENCES "OutputFile"(id);

ALTER TABLE "FinancialGoal" 
ADD CONSTRAINT "fk_FinancialGoal_accounts" 
FOREIGN KEY ("accounts_id") REFERENCES "Account"(id);

ALTER TABLE "FinancialGoal" 
ADD CONSTRAINT "fk_FinancialGoal_extRetirementGoal" 
FOREIGN KEY ("extRetirementGoal_id") REFERENCES "RetirementGoal"(id);

ALTER TABLE "FinancialGoal" 
ADD CONSTRAINT "fk_FinancialGoal_participants" 
FOREIGN KEY ("participants_id") REFERENCES "Person"(id);

ALTER TABLE "FinancialGoal" 
ADD CONSTRAINT "fk_FinancialGoal_retirementState" 
FOREIGN KEY ("retirementState_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "FinancialInstitution" 
ADD CONSTRAINT "fk_FinancialInstitution_additionalRoutingNumbers" 
FOREIGN KEY ("additionalRoutingNumbers_id") REFERENCES "RoutingNumber"(id);

ALTER TABLE "FinancialInstitution" 
ADD CONSTRAINT "fk_FinancialInstitution_address" 
FOREIGN KEY ("address_id") REFERENCES "Address"(id);

ALTER TABLE "FinancialInstitution" 
ADD CONSTRAINT "fk_FinancialInstitution_organizationalUnit" 
FOREIGN KEY ("organizationalUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "FormGenerationCriteria" 
ADD CONSTRAINT "fk_FormGenerationCriteria_esignatureDetails" 
FOREIGN KEY ("esignatureDetails_id") REFERENCES "EsignaturePositions"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel0" 
FOREIGN KEY ("ouLevel0_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel1" 
FOREIGN KEY ("ouLevel1_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel2" 
FOREIGN KEY ("ouLevel2_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel3" 
FOREIGN KEY ("ouLevel3_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel4" 
FOREIGN KEY ("ouLevel4_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel5" 
FOREIGN KEY ("ouLevel5_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_ouLevel6" 
FOREIGN KEY ("ouLevel6_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "J_Transaction" 
ADD CONSTRAINT "fk_J_Transaction_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "MarginInterest" 
ADD CONSTRAINT "fk_MarginInterest_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "MarginRequirements" 
ADD CONSTRAINT "fk_MarginRequirements_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "MultiAccountBuilder" 
ADD CONSTRAINT "fk_MultiAccountBuilder_accountCreationList" 
FOREIGN KEY ("accountCreationList_id") REFERENCES "AccountBuilder"(id);

ALTER TABLE "MultiAccountCreation" 
ADD CONSTRAINT "fk_MultiAccountCreation_accountCreationList" 
FOREIGN KEY ("accountCreationList_id") REFERENCES "AccountCreation"(id);

ALTER TABLE "OnlineAccountSetup" 
ADD CONSTRAINT "fk_OnlineAccountSetup_accountsToLink" 
FOREIGN KEY ("accountsToLink_id") REFERENCES "Account"(id);

ALTER TABLE "OnlineAccountSetup" 
ADD CONSTRAINT "fk_OnlineAccountSetup_person" 
FOREIGN KEY ("person_id") REFERENCES "Person"(id);

ALTER TABLE "OnlineAccountSetup" 
ADD CONSTRAINT "fk_OnlineAccountSetup_securityQuestionsAndAnswers" 
FOREIGN KEY ("securityQuestionsAndAnswers_id") REFERENCES "OnlineAccountSecurityQA"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel0" 
FOREIGN KEY ("ouLevel0_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel1" 
FOREIGN KEY ("ouLevel1_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel2" 
FOREIGN KEY ("ouLevel2_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel3" 
FOREIGN KEY ("ouLevel3_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel4" 
FOREIGN KEY ("ouLevel4_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel5" 
FOREIGN KEY ("ouLevel5_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitAccountBalances" 
ADD CONSTRAINT "fk_OrgUnitAccountBalances_ouLevel6" 
FOREIGN KEY ("ouLevel6_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_orgUnit" 
FOREIGN KEY ("orgUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel0" 
FOREIGN KEY ("ouLevel0_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel1" 
FOREIGN KEY ("ouLevel1_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel2" 
FOREIGN KEY ("ouLevel2_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel3" 
FOREIGN KEY ("ouLevel3_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel4" 
FOREIGN KEY ("ouLevel4_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel5" 
FOREIGN KEY ("ouLevel5_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_ouLevel6" 
FOREIGN KEY ("ouLevel6_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitPositions" 
ADD CONSTRAINT "fk_OrgUnitPositions_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "OrgUnitRelation" 
ADD CONSTRAINT "fk_OrgUnitRelation_childUnit" 
FOREIGN KEY ("childUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrgUnitRelation" 
ADD CONSTRAINT "fk_OrgUnitRelation_parentUnit" 
FOREIGN KEY ("parentUnit_id") REFERENCES "OrganizationalUnit"(id);

ALTER TABLE "OrganizationalUnit" 
ADD CONSTRAINT "fk_OrganizationalUnit_address" 
FOREIGN KEY ("address_id") REFERENCES "Address"(id);

ALTER TABLE "OrganizationalUnit" 
ADD CONSTRAINT "fk_OrganizationalUnit_childUnits" 
FOREIGN KEY ("childUnits_id") REFERENCES "OrgUnitRelation"(id);

ALTER TABLE "OutputFile" 
ADD CONSTRAINT "fk_OutputFile_expectedFiles" 
FOREIGN KEY ("expectedFiles_id") REFERENCES "ExpectedFile"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_accreditedInvestor" 
FOREIGN KEY ("accreditedInvestor_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_alternateMailingAddress" 
FOREIGN KEY ("alternateMailingAddress_id") REFERENCES "Address"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_assets" 
FOREIGN KEY ("assets_id") REFERENCES "Assets"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_associatedWithBrokerDealer" 
FOREIGN KEY ("associatedWithBrokerDealer_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_associatedWithInvestmentAdvisor" 
FOREIGN KEY ("associatedWithInvestmentAdvisor_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_associatedWithOtherBrokerDealer" 
FOREIGN KEY ("associatedWithOtherBrokerDealer_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_beneficiaries" 
FOREIGN KEY ("beneficiaries_id") REFERENCES "Beneficiary"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_contingentBeneficiaries" 
FOREIGN KEY ("contingentBeneficiaries_id") REFERENCES "Beneficiary"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_countryOfCitizenship" 
FOREIGN KEY ("countryOfCitizenship_id") REFERENCES "Country"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_countryOfResidence" 
FOREIGN KEY ("countryOfResidence_id") REFERENCES "Country"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_employerAddress" 
FOREIGN KEY ("employerAddress_id") REFERENCES "Address"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_foreignOfficial" 
FOREIGN KEY ("foreignOfficial_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_governingStateLawForTrust" 
FOREIGN KEY ("governingStateLawForTrust_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_grantor" 
FOREIGN KEY ("grantor_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_holdings" 
FOREIGN KEY ("holdings_id") REFERENCES "Holdings"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_kyCInfo" 
FOREIGN KEY ("kyCInfo_id") REFERENCES "KyCInfo"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_legalAddress" 
FOREIGN KEY ("legalAddress_id") REFERENCES "Address"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_liabilities" 
FOREIGN KEY ("liabilities_id") REFERENCES "Liabilities"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_mailingAddress" 
FOREIGN KEY ("mailingAddress_id") REFERENCES "Address"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_otherDocuments" 
FOREIGN KEY ("otherDocuments_id") REFERENCES "Document"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_previousLegalAddress" 
FOREIGN KEY ("previousLegalAddress_id") REFERENCES "Address"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_proofOfAddress" 
FOREIGN KEY ("proofOfAddress_id") REFERENCES "Document"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_proofOfIdentity" 
FOREIGN KEY ("proofOfIdentity_id") REFERENCES "ProofOfIdentity"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_proofOfIncome" 
FOREIGN KEY ("proofOfIncome_id") REFERENCES "Document"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_publicCompanyOfficial" 
FOREIGN KEY ("publicCompanyOfficial_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_regulatoryDisclosuresV0" 
FOREIGN KEY ("regulatoryDisclosuresV0_id") REFERENCES "RegulatoryDisclosureV0"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_relatedPersons" 
FOREIGN KEY ("relatedPersons_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_relatedToPublicCompanyOfficial" 
FOREIGN KEY ("relatedToPublicCompanyOfficial_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_revoker" 
FOREIGN KEY ("revoker_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_secondCountryOfCitizenship" 
FOREIGN KEY ("secondCountryOfCitizenship_id") REFERENCES "Country"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_securitiesIndustryAffiliation" 
FOREIGN KEY ("securitiesIndustryAffiliation_id") REFERENCES "RegulatoryDisclosure"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_securityQuestionsAndAnswers" 
FOREIGN KEY ("securityQuestionsAndAnswers_id") REFERENCES "OnlineAccountSecurityQA"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_spouse" 
FOREIGN KEY ("spouse_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_successorTrustee" 
FOREIGN KEY ("successorTrustee_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "Person" 
ADD CONSTRAINT "fk_Person_trustee" 
FOREIGN KEY ("trustee_id") REFERENCES "PersonRelation"(id);

ALTER TABLE "PersonRelation" 
ADD CONSTRAINT "fk_PersonRelation_sourcePerson" 
FOREIGN KEY ("sourcePerson_id") REFERENCES "Person"(id);

ALTER TABLE "PersonRelation" 
ADD CONSTRAINT "fk_PersonRelation_targetPerson" 
FOREIGN KEY ("targetPerson_id") REFERENCES "Person"(id);

ALTER TABLE "Position" 
ADD CONSTRAINT "fk_Position_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "Position" 
ADD CONSTRAINT "fk_Position_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "Product" 
ADD CONSTRAINT "fk_Product_features" 
FOREIGN KEY ("features_id") REFERENCES "ProductFeatures"(id);

ALTER TABLE "Product" 
ADD CONSTRAINT "fk_Product_productCategory" 
FOREIGN KEY ("productCategory_id") REFERENCES "ProductCategory"(id);

ALTER TABLE "Product" 
ADD CONSTRAINT "fk_Product_provider" 
FOREIGN KEY ("provider_id") REFERENCES "ProductProvider"(id);

ALTER TABLE "ProductFeatures" 
ADD CONSTRAINT "fk_ProductFeatures_feature" 
FOREIGN KEY ("feature_id") REFERENCES "Product"(id);

ALTER TABLE "ProofOfIdentity" 
ADD CONSTRAINT "fk_ProofOfIdentity_document" 
FOREIGN KEY ("document_id") REFERENCES "Document"(id);

ALTER TABLE "ProofOfIdentity" 
ADD CONSTRAINT "fk_ProofOfIdentity_issuingCountry" 
FOREIGN KEY ("issuingCountry_id") REFERENCES "Country"(id);

ALTER TABLE "ProofOfIdentity" 
ADD CONSTRAINT "fk_ProofOfIdentity_issuingState" 
FOREIGN KEY ("issuingState_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "ReceivedFile" 
ADD CONSTRAINT "fk_ReceivedFile_expectedFile" 
FOREIGN KEY ("expectedFile_id") REFERENCES "ExpectedFile"(id);

ALTER TABLE "RegistrationType" 
ADD CONSTRAINT "fk_RegistrationType_custodian" 
FOREIGN KEY ("custodian_id") REFERENCES "Custodian"(id);

ALTER TABLE "RegistrationTypeGroup" 
ADD CONSTRAINT "fk_RegistrationTypeGroup_registrationTypes" 
FOREIGN KEY ("registrationTypes_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "RegulatoryDisclosure" 
ADD CONSTRAINT "fk_RegulatoryDisclosure_firmAddress" 
FOREIGN KEY ("firmAddress_id") REFERENCES "Address"(id);

ALTER TABLE "RegulatoryDisclosure" 
ADD CONSTRAINT "fk_RegulatoryDisclosure_foreignCountry" 
FOREIGN KEY ("foreignCountry_id") REFERENCES "Country"(id);

ALTER TABLE "RegulatoryDisclosure" 
ADD CONSTRAINT "fk_RegulatoryDisclosure_regulatoryDisclosureOption" 
FOREIGN KEY ("regulatoryDisclosureOption_id") REFERENCES "RegulatoryDisclosureOption"(id);

ALTER TABLE "RegulatoryDisclosureV0" 
ADD CONSTRAINT "fk_RegulatoryDisclosureV0_foreignCountry" 
FOREIGN KEY ("foreignCountry_id") REFERENCES "Country"(id);

ALTER TABLE "RepCodeAccountBalances" 
ADD CONSTRAINT "fk_RepCodeAccountBalances_repCode" 
FOREIGN KEY ("repCode_id") REFERENCES "RepCode"(id);

ALTER TABLE "RepCodeSplit" 
ADD CONSTRAINT "fk_RepCodeSplit_sourceRepCode" 
FOREIGN KEY ("sourceRepCode_id") REFERENCES "RepCode"(id);

ALTER TABLE "RepCodeSplit" 
ADD CONSTRAINT "fk_RepCodeSplit_targetRepCode" 
FOREIGN KEY ("targetRepCode_id") REFERENCES "RepCode"(id);

ALTER TABLE "RepPositions" 
ADD CONSTRAINT "fk_RepPositions_repCode" 
FOREIGN KEY ("repCode_id") REFERENCES "RepCode"(id);

ALTER TABLE "RepPositions" 
ADD CONSTRAINT "fk_RepPositions_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "RequriedDocumentsCriteria" 
ADD CONSTRAINT "fk_RequriedDocumentsCriteria_documentType" 
FOREIGN KEY ("documentType_id") REFERENCES "RequiredDocument"(id);

ALTER TABLE "RequriedDocumentsCriteria" 
ADD CONSTRAINT "fk_RequriedDocumentsCriteria_fundingMethodInfo" 
FOREIGN KEY ("fundingMethodInfo_id") REFERENCES "FundingMethodTypes"(id);

ALTER TABLE "RequriedDocumentsCriteria" 
ADD CONSTRAINT "fk_RequriedDocumentsCriteria_registrationTypeInfo" 
FOREIGN KEY ("registrationTypeInfo_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "RetirementPlanSummary" 
ADD CONSTRAINT "fk_RetirementPlanSummary_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "RoutingNumber" 
ADD CONSTRAINT "fk_RoutingNumber_state" 
FOREIGN KEY ("state_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "SecuritiesTransferSourceOrReceiver" 
ADD CONSTRAINT "fk_SecuritiesTransferSourceOrReceiver_accountOwners" 
FOREIGN KEY ("accountOwners_id") REFERENCES "Person"(id);

ALTER TABLE "SecuritiesTransferSourceOrReceiver" 
ADD CONSTRAINT "fk_SecuritiesTransferSourceOrReceiver_firmAddress" 
FOREIGN KEY ("firmAddress_id") REFERENCES "Address"(id);

ALTER TABLE "SecuritiesTransferSourceOrReceiver" 
ADD CONSTRAINT "fk_SecuritiesTransferSourceOrReceiver_payeeAddress" 
FOREIGN KEY ("payeeAddress_id") REFERENCES "Address"(id);

ALTER TABLE "SecuritiesTransferSourceOrReceiver" 
ADD CONSTRAINT "fk_SecuritiesTransferSourceOrReceiver_registrationType" 
FOREIGN KEY ("registrationType_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "Security" 
ADD CONSTRAINT "fk_Security_product" 
FOREIGN KEY ("product_id") REFERENCES "Product"(id);

ALTER TABLE "Security" 
ADD CONSTRAINT "fk_Security_securityType" 
FOREIGN KEY ("securityType_id") REFERENCES "SecurityType"(id);

ALTER TABLE "SecurityRestriction" 
ADD CONSTRAINT "fk_SecurityRestriction_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "SecurityType" 
ADD CONSTRAINT "fk_SecurityType_custodian" 
FOREIGN KEY ("custodian_id") REFERENCES "Custodian"(id);

ALTER TABLE "SecurityTypeCustodianMapping" 
ADD CONSTRAINT "fk_SecurityTypeCustodianMapping_custodian" 
FOREIGN KEY ("custodian_id") REFERENCES "Custodian"(id);

ALTER TABLE "SecurityTypeCustodianMapping" 
ADD CONSTRAINT "fk_SecurityTypeCustodianMapping_securityType" 
FOREIGN KEY ("securityType_id") REFERENCES "SecurityType"(id);

ALTER TABLE "SrCategory" 
ADD CONSTRAINT "fk_SrCategory_subCategory" 
FOREIGN KEY ("subCategory_id") REFERENCES "SrSubCategory"(id);

ALTER TABLE "SrDefinition" 
ADD CONSTRAINT "fk_SrDefinition_category" 
FOREIGN KEY ("category_id") REFERENCES "SrCategory"(id);

ALTER TABLE "SrDefinition" 
ADD CONSTRAINT "fk_SrDefinition_mergeReadQuery" 
FOREIGN KEY ("mergeReadQuery_id") REFERENCES "SrQuery"(id);

ALTER TABLE "SrDefinition" 
ADD CONSTRAINT "fk_SrDefinition_subCategory" 
FOREIGN KEY ("subCategory_id") REFERENCES "SrSubCategory"(id);

ALTER TABLE "SrDefinition" 
ADD CONSTRAINT "fk_SrDefinition_tasks" 
FOREIGN KEY ("tasks_id") REFERENCES "SrTaskDef"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_additionalInfo" 
FOREIGN KEY ("additionalInfo_id") REFERENCES "SrAdditionalInfo"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_currentTask" 
FOREIGN KEY ("currentTask_id") REFERENCES "SrTask"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_documents" 
FOREIGN KEY ("documents_id") REFERENCES "Document"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_notes" 
FOREIGN KEY ("notes_id") REFERENCES "SrNote"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_srDef" 
FOREIGN KEY ("srDef_id") REFERENCES "SrDefinition"(id);

ALTER TABLE "SrInstance" 
ADD CONSTRAINT "fk_SrInstance_tasks" 
FOREIGN KEY ("tasks_id") REFERENCES "SrTask"(id);

ALTER TABLE "SrStatus" 
ADD CONSTRAINT "fk_SrStatus_status" 
FOREIGN KEY ("status_id") REFERENCES "SrStatusCode"(id);

ALTER TABLE "SrTask" 
ADD CONSTRAINT "fk_SrTask_assignedTo" 
FOREIGN KEY ("assignedTo_id") REFERENCES "Associate"(id);

ALTER TABLE "SrTask" 
ADD CONSTRAINT "fk_SrTask_currentStatus" 
FOREIGN KEY ("currentStatus_id") REFERENCES "SrStatus"(id);

ALTER TABLE "SrTask" 
ADD CONSTRAINT "fk_SrTask_signatures" 
FOREIGN KEY ("signatures_id") REFERENCES "Signature"(id);

ALTER TABLE "SrTask" 
ADD CONSTRAINT "fk_SrTask_status" 
FOREIGN KEY ("status_id") REFERENCES "SrStatus"(id);

ALTER TABLE "SrTaskDef" 
ADD CONSTRAINT "fk_SrTaskDef_status" 
FOREIGN KEY ("status_id") REFERENCES "SrStatusCode"(id);

ALTER TABLE "SrWorkflowArgs" 
ADD CONSTRAINT "fk_SrWorkflowArgs_errors" 
FOREIGN KEY ("errors_id") REFERENCES "Error"(id);

ALTER TABLE "StateOrProvince" 
ADD CONSTRAINT "fk_StateOrProvince_country" 
FOREIGN KEY ("country_id") REFERENCES "Country"(id);

ALTER TABLE "StepVisibilityCriteria" 
ADD CONSTRAINT "fk_StepVisibilityCriteria_registrationGroup" 
FOREIGN KEY ("registrationGroup_id") REFERENCES "RegistrationTypeGroup"(id);

ALTER TABLE "StepVisibilityCriteria" 
ADD CONSTRAINT "fk_StepVisibilityCriteria_step" 
FOREIGN KEY ("step_id") REFERENCES "AccountCreationStep"(id);

ALTER TABLE "SupportingDocuments" 
ADD CONSTRAINT "fk_SupportingDocuments_registrationTypeInfo" 
FOREIGN KEY ("registrationTypeInfo_id") REFERENCES "RegistrationType"(id);

ALTER TABLE "Task" 
ADD CONSTRAINT "fk_Task_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "Task" 
ADD CONSTRAINT "fk_Task_assignedTo" 
FOREIGN KEY ("assignedTo_id") REFERENCES "Associate"(id);

ALTER TABLE "TaxLot" 
ADD CONSTRAINT "fk_TaxLot_account" 
FOREIGN KEY ("account_id") REFERENCES "Account"(id);

ALTER TABLE "TaxLot" 
ADD CONSTRAINT "fk_TaxLot_currency" 
FOREIGN KEY ("currency_id") REFERENCES "Currency"(id);

ALTER TABLE "TaxLot" 
ADD CONSTRAINT "fk_TaxLot_security" 
FOREIGN KEY ("security_id") REFERENCES "Security"(id);

ALTER TABLE "Transfer" 
ADD CONSTRAINT "fk_Transfer_bankAccount" 
FOREIGN KEY ("bankAccount_id") REFERENCES "AccountSourceOfFunds"(id);

ALTER TABLE "Transfer" 
ADD CONSTRAINT "fk_Transfer_otherAccount" 
FOREIGN KEY ("otherAccount_id") REFERENCES "SecuritiesTransferSourceOrReceiver"(id);

ALTER TABLE "Transfer" 
ADD CONSTRAINT "fk_Transfer_securities" 
FOREIGN KEY ("securities_id") REFERENCES "SecuritiesTransferSecurity"(id);

ALTER TABLE "Transfer" 
ADD CONSTRAINT "fk_Transfer_sender" 
FOREIGN KEY ("sender_id") REFERENCES "Person"(id);

ALTER TABLE "Transfer" 
ADD CONSTRAINT "fk_Transfer_taxFilingState" 
FOREIGN KEY ("taxFilingState_id") REFERENCES "StateOrProvince"(id);

ALTER TABLE "ValidationConfig" 
ADD CONSTRAINT "fk_ValidationConfig_rule" 
FOREIGN KEY ("rule_id") REFERENCES "ValidationRule"(id);