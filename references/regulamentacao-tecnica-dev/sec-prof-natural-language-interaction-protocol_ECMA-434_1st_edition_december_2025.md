# sec-prof-natural-language-interaction-protocol_ECMA-434_1st_edition_december_2025

> Fonte: `sec-prof-natural-language-interaction-protocol_ECMA-434_1st_edition_december_2025.pdf`

          ECMA-434
          1st Edition / December 2025




Security profiles for
Natural Language
Interaction Protocol
(NLIP)




                           Reference number
                            ECMA-123:2009



                    © Ecma International 2009
COPYRIGHT PROTECTED DOCUMENT


                               © Ecma International 2025
Contents                                                                                                                                                         Page


1           Scope ...................................................................................................................................................... 1
2           Conformance ......................................................................................................................................... 1
3           Normative references ............................................................................................................................ 1
4           Terms and definitions ........................................................................................................................... 2
5           Notational conventions ......................................................................................................................... 2
6           Overview ................................................................................................................................................. 2
7           Security profiles .................................................................................................................................... 3
7.1         Agent Security Profile 1 (Mandatory) .................................................................................................. 3
7.1.1       Transport Layer Security ...................................................................................................................... 3
7.1.2       Identity & Authentication: NLIP Agent Authentication ...................................................................... 3
7.1.3       Agent Lifecycle: Ethical-by-Design ..................................................................................................... 3
7.2         Agent Security Profile 2 ........................................................................................................................ 3
7.2.1       Identity & Authentication: NLIP Client Authentication ...................................................................... 4
7.2.2       Runtime & Behaviour: NLIP Client Authorization .............................................................................. 4
7.2.3       Runtime & Behaviour: Privilege Misuse Prevention .......................................................................... 4
7.2.4       Observability & Audit: Agent Behaviours ........................................................................................... 4
7.2.5       Observability & Audit: Client Throttling and DoS .............................................................................. 4
7.2.6       Observability & Audit: Data Governance and Privacy ....................................................................... 4
7.2.7       Agent Lifecycle: Secure-by-Design Disclosure ................................................................................. 4
7.3         Agent Security Profile 3 ........................................................................................................................ 4
7.3.1       Prevention of Prompt Injection (including Indirect Prompt Injection) ............................................. 4
7.3.2       Runtime Agent Behaviour Controls .................................................................................................... 5
7.3.3       Information Leakage ............................................................................................................................. 5
Annex A (informative) NLIP Secure-by-Design Disclosure Template ........................................................... 7
Annex B (informative) NLIP Ethical-by-design disclosure template/text ...................................................... 9
B.1   For Agent Security Profile 1 ................................................................................................................. 9
B.2   For Agent Security Profile 2 (recommended for Enterprise Deployment) ...................................... 9
Bibliography ...................................................................................................................................................... 11




© Ecma International 2025                                                                                                                                                i
Introduction
The technology of Artificial Intelligence has the potential to be truly transformative to society. Despite some
limitations, the technology is capable of many functions, including but not limited to answering questions,
translating, describing and summarizing multi-modal content, generating new content, and summarizing large
volumes of information. This enables the creation of intelligent agents that can use AI to analyze data and
provide new services.

A much bigger boost to the social benefits of AI technology can be obtained by interactions among different
intelligent agents, which may be under the control of different organizations and users. The interaction among
intelligent agents can unlock new economic and social value, just like the interactions among various Internet-
based services was enabled with the advent of the web browser.

We need a standard common protocol that is used by humans to interact with an intelligent agent, and for
intelligent agents to interact with each other.

Ecma Technical Committee 56 is defining this Standard. Four Standards define the standard protocol called
Natural Language Interaction Protocol (NLIP), its binding over HTTPS/REST, its binding over websockets and
its binding over AMQP.

Security is an important aspect of any system that implements a protocol. In order to properly secure the
implementations of NLIP while maintaining interoperability, a set of recommendations for security management
is needed. This Standard provides that requisite set of recommendations.

This recommendation is targeted at security engineers, site reliability engineers (SREs), architects, Chief
Information Security Officers (CISO), and compliance teams deploying NLIP agents at enterprise-scale. This
Standard defines a set of standard security profiles which should be used in NLIP implementations.

Details for the security guidelines implementation can be found in an exemplar living document at URL
https://github.com/nlip-project/security_guidelines.




This Ecma Standard was developed by Technical Committee 56 and was adopted by the General
Assembly of December 2025.




ii                                                                                       © Ecma International 2025
COPYRIGHT NOTICE
© 2025 Ecma International
By obtaining and/or copying this work, you (the licensee) agree that you have read, understood, and will
comply with the following terms and conditions.
This document may be copied, published and distributed to others, and certain derivative works of it may
be prepared, copied, published, and distributed, in whole or in part, provided that the above copyright
notice and this Copyright License and Disclaimer are included on all such copies and derivative works.
The only derivative works that are permissible under this Copyright License and Disclaimer are:
(i)   works which incorporate all or portion of this document for the purpose of providing commentary or
      explanation (such as an annotated version of the document),
(ii) works which incorporate all or portion of this document for the purpose of incorporating features that
     provide accessibility,
(iii) translations of this document into languages other than English and into different formats and
(iv) works by making use of this specification in standard conformant products by implementing (e.g. by
     copy and paste wholly or partly) the functionality therein.
However, the content of this document itself may not be modified in any way, including by removing the
copyright notice or references to Ecma International, except as required to translate it into languages
other than English or into a different format.
The official version of an Ecma International document is the English language version on the Ecma
International website. In the event of discrepancies between a translated version and the official version,
the official version shall govern.
The limited permissions granted above are perpetual and will not be revoked by Ecma International or
its successors or assigns.
This document and the information contained herein is provided on an "AS IS" basis and ECMA
INTERNATIONAL DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
TO ANY WARRANTY THAT THE USE OF THE INFORMATION HEREIN WILL NOT INFRINGE ANY
OWNERSHIP RIGHTS OR ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A
PARTICULAR PURPOSE.




© Ecma International 2025                                                                                iii
Security profiles for Natural Language Interaction Protocol
(NLIP)



1      Scope

This Standard establishes the Agent Security Profiles for NLIP as a standalone Ecma Standard. Each Security
Profile defines a set of mandatory security requirements for an agent implementing NLIP. Conformance to this
Standard is mandatory for any implementation claiming NLIP conformance.

Details on how the security guidelines described in this Standard should be implemented are out of scope of
this Standard.

This Standard does not cover aspects related to internals of foundation-models, safeguards for physical data
centers, or issues related to national export controls.


2      Conformance

Conforming implementations should satisfy the requirements of at least one of the security profiles defined in
this document.

An implementation may be fully conformant or partially conformant with profile 2 and profile 3. A partially
conformant profile 2 implementation implements all SCOs in profile 1 and at least one of the SCOs in profile 2.
A fully conformant profile 2 implementation implements all SCOs in profile 1 and profile 2.

A partially conformant profile 3 implementation implements all SCOs in profile 1, at least one of the SCOs in
profile 2, and at least one of the SCOs in profile 3. A fully conformant profile 3 implementation implements all
SCOs in profile 1, profile 2 and profile 3.


3      Normative references

The following documents are referred to in the text in such a way that some or all of their content constitutes
requirements of this document. For dated references, only the edition cited applies. For undated references, the
latest edition of the referenced document (including any amendments) applies.

ECMA-404, The JSON Data Interchange Syntax, 2nd edition (December 2017)

ECMA-431, Binding of the Natural Language Interaction Protocol (NLIP) over HTTP/HTTPS

ECMA-432, Binding of the Natural Language Interaction Protocol (NLIP) over WebSocket

ECMA-433, Binding of the Natural Language Interaction Protocol (NLIP) over AMQP

IETF RFC 2119, Key words for use in RFCs to Indicate Requirement Levels
[https://datatracker.ietf.org/doc/rfc2119]

IETF RFC 8446, The Transport Layer Security (TLS) Protocol Version 1.3
[https://datatracker.ietf.org/docrfc8446]




© Ecma International 2025                                                                                     1
4     Terms and definitions

4.1
security countermeasures and objectives (SCO)
a SCO is a set of security goals relevant to agentic systems and measures, along with approaches and
strategies to achieve the goals.

4.2
agent security profile
an agent security profile is a pre-defined checklist of security countermeasures and objectives (SCO) in agent
development and deployment.

4.3
red teaming
red teaming is the practice of simulating real-world attackers to test an agentic system’s defences, focusing on
its ability to detect, respond, and recover rather than just finding vulnerabilities.


5     Notational conventions

In this Standard, the following conventions that are consistent with IETF RFC 2119 are used:

•   “Shall” indicates that the item is an absolute requirement of the specification

•   “Should” indicates that there may exist valid reasons in particular circumstances to ignore a particular item,
    but the full implications must be understood and carefully weighed before choosing a different course.

•   “May” indicates that that an item is truly optional. One vendor may choose to include the item because a
    particular marketplace requires it or because the vendor feels that it enhances the product while another
    vendor may omit the same item. An implementation which does not include a particular option shall be
    prepared to interoperate with another implementation which does include the option, though perhaps with
    reduced functionality. In the same vein an implementation which does include a particular option shall be
    prepared to interoperate with another implementation which does not include the option (except, of course,
    for the feature the option provides.)


6     Overview
NLIP has been securely designed to proactively consider or address known security threats to agentic AI
systems. Meanwhile, NLIP is designed to support agent deployment along with defense solutions in the AI and
agentic AI space (e.g., tools or algorithms that can filter prompt injections, jailbreakings, etc.).

NLIP applications shall conform to the principles of secure-by-design. NLIP provides three levels of security
profiles. An NLIP security profile is a pre-defined checklist of security countermeasures and objectives (SCO)
in NLIP-based application development and deployment. These SCOs are tailored to relevant types of threats
or risks to NLIP agents, NLIP clients, and more generally NLIP-based agentic systems.

For enterprise applications, red teaming is encouraged before agents get moved to production, to ensure that
security vulnerabilities can be identified, classified, and counter-measures implemented into the agentic system
based on targeted deployment and intended use cases.

The goal for providing pre-defined security profiles is to simplify NLIP-based application development and
deployment, by providing relevant guidance and checklists that leads to security-assured, privacy-preserving,
and regulation-compliant NLIP applications which are vital for building trust in agentic systems.

Security profiles are not required for NLIP conforming applications intended only for proof-of-concepts or
applications intended to demonstrate a concept. Security profiles are required for NLIP conforming applications




2                                                                                          © Ecma International 2025
that will be moved to production and used in consumer and/or enterprise applications, regardless of how they
are hosted.


7       Security profiles

This clause summarizes three security profiles, namely Agent Security Profile 1, 2, and 3 (also referred to as
Profile 1, 2, and 3 in this document), with security assurance progressively increasing from Profile 1 to Profile
3.

Agent Security Profile 1 includes a minimum list of SCOs that are mandated by NLIP. Profile 2 and Profile 3
each defines a list of SCOs with special consideration of security threats to (1) enterprise-level NLIP deployment
and (2) external service providers’ NLIP deployment, respectively. While Profile 1 is mandatory to be NLIP-
compliant, specific applications can further choose to implement either Profile 2 or Profile 3, or a subset of SCOs
in them, based on specific security assurance needs and threats in their development and deployment
environments.

7.1      Agent Security Profile 1 (Mandatory)

An implementation conforming to security profile 1 shall support the requirement in the following subclauses.

7.1.1      Transport Layer Security

An NLIP agent shall use Transport Layer Security with message integrity in the communication between (1)
NLIP clients and NLIP agents (i.e., NLIP servers) and (2) between NLIP agents and NLIP agents.

7.1.2      Identity & Authentication: NLIP Agent Authentication

An NLIP client shall authenticate the NLIP agent(s), by identifying the agent(s) that it is communicating with.
This authentication can leverage known secure practices or protocols such as verification of the agent’s
certificate associated with the agent’s endpoint.

7.1.3      Agent Lifecycle: Ethical-by-Design

NLIP agents shall support the following ethical principles during their software life-cycle:

(i) Respect for human autonomy

(ii) Prevention of harm

(iii) Fairness

(iv) Explicability

These principles are detailed in [Ethics Guidelines for Trustworthy AI – Independent High-level expert group on
Artificial Intelligence set up by The European Commission]. Annex B illustrates an ethics statement and
actionable ethics checklist.

NLIP agents shall provide a statement regarding ethical development and use of the agent. The statement shall
be publicly available. The statement may be published with the technical documentation for the agent, user
documentation for the agent, or a public-facing end-point of the agent.

7.2      Agent Security Profile 2

Enterprise deployments of NLIP agents should implement this agent security profile.




© Ecma International 2025                                                                                        3
Agent Security Profile 2 includes everything in Agent Security Profile 1 as well as the following SCOs. NLIP
agents conformant to security profile 2 shall implement at least one of the SCOs in this clause. While NLIP does
not mandate implementation of Profile 2, it is highly recommended.

7.2.1     Identity & Authentication: NLIP Client Authentication

NLIP agents implementing profile 2 should authenticate NLIP clients, using secure practices or protocols such
as OAuth.

7.2.2     Runtime & Behaviour: NLIP Client Authorization

NLIP agents should authorize NLIP clients for their requests before security-sensitive and privacy-sensitive
actions are taken and resources are accessed or returned. Examples of the agents’ actions include invocation
of specific tools, external services or AI models. Examples of resources include datasets or tools.

7.2.3     Runtime & Behaviour: Privilege Misuse Prevention

NLIP agents should avoid misusing their privileges to perform actions or request resources on behalf of low-
privileged clients. This is to prevent Confused Deputy attack in Web, mobile or other traditional systems.

7.2.4     Observability & Audit: Agent Behaviours

NLIP agent’s behaviours should be traceable across multi-agent chains and agent-client chains, auditable for
compliance and forensic needs, and cost-aware to help prevent budget overruns.

7.2.5     Observability & Audit: Client Throttling and DoS

NLIP agents should implement throttling for unauthenticated/authenticated clients to prevent flooding and
denial-of-service attacks. For example, malicious NLIP clients can flood expensive agent endpoints, driving up
compute cost and starving legitimate traffic.

7.2.6     Observability & Audit: Data Governance and Privacy

NLIP agents should be compliant with relevant regulatory requirements when collecting and sharing personal
data. For example, for deployments where GDPR applies, NLIP agents with their owning party may be
reasonably considered as “Data Controllers” and are ultimately responsible for compliance.

7.2.7     Agent Lifecycle: Secure-by-Design Disclosure

Developers of NLIP agents should provide transparency in their efforts towards security for their applications.
Annex B illustrates an exemplar actionable checklist that can be used to provide transparency.

7.3     Agent Security Profile 3

This agent security profile is recommended for service providers.

Agent Security Profile 3 includes everything in Agent Security Profile 2 as well as the following SCOs. NLIP
agents conformant to profile 3 shall implement all SCOs in profile 1, at least one SCO in profile 2 and at least
one SCOs in profile 3.

7.3.1     Prevention of Prompt Injection (including Indirect Prompt Injection)

NLIP agents should be deployed with countermeasures to detect or filter out potentially malicious contents
which the agent may use to construct prompts to AI models. The untrusted contents can come from, for example,
human users, other agents, tools, datasets, or external services.




4                                                                                         © Ecma International 2025
7.3.2      Runtime Agent Behaviour Controls

NLIP agents should be deployed with security countermeasures to limit, monitor, and validate agent behaviour
during execution.

7.3.3      Information Leakage

NLIP agents should be deployed with countermeasures to check their outputs to clients to prevent leakage of
secrets, such as chain-of-thoughts or other agent-internal information (e.g., Vector DB and logs).




© Ecma International 2025                                                                                 5
6   © Ecma International 2025
                                                    Annex A
                                                  (informative)

                            NLIP Secure-by-Design Disclosure Template


This template is based on NIST Recommended Criteria for Cybersecurity Labelling of Consumer Software, per
Executive Order 14028, Improving the Nation’s Cybersecurity. This template may be modified to align to other
frameworks that may be more aligned with the intended use cases. For enterprise deployments follow best
practices on expanded documentation for cybersecurity labelling.

SECURITY.md to be included in the main repository for NLIP agents

# Security Compliance Statement

This application conforms to the **Natural Language Interaction Protocol (NLIP)** security guidelines and
follows NIST’s *Recommended Criteria for Cybersecurity Labeling of Consumer Software* (CSWP 02042022-
1).

---

## Descriptive Claims

- **Claimant:** [Developer / Maintainer Name]

- **Label Scope:** [App name, version, platform(s)]

- **Claim Date:** YYYY-MM

- **Security Update Status:** Supported / Unsupported

- **Update Method:** [e.g., GitHub releases, npm/pip package updates]

- **Vulnerability disclosure policy:** Link to policy or state here

---

## Secure Development Practices

- [ ] Secure coding practices aligned with NIST SSDF (SP 800-218) or equivalent.

- [ ] No hard-coded secrets.

- [ ] Cryptography uses [AES-256 / TLS 1.3] or stronger.

- [ ] Security updates provided for [minimum duration or “unspecified”].

---

## Contact

For security issues or disclosures, please contact: security@[domain].com




© Ecma International 2025                                                                                 7
8   © Ecma International 2025
                                                  Annex B
                                                (informative)

                      NLIP Ethical-by-design disclosure template/text


To demonstrate conformity to ethical-by-design, we provide the following text and template illustrations that
serve as starting points for developers to and adapt to their intended use.

These templates may be modified to align to relevant frameworks that may be more aligned with the intended
use cases.


B.1 For Agent Security Profile 1

If your agent adopts Agent Security Profile 1, it is mandatory to include an ethical statement of the developer’s
choosing. One example of such is shown below:

# Ethical compliance statement (example text)

“This application has been developed for responsible use by users in the {specified domain). It neither causes
nor exacerbates harm or otherwise adversely affects human beings. This entails the protection of human dignity
as well as mental and physical integrity.”


B.2 For Agent Security Profile 2 (recommended for Enterprise Deployment)

This template is based on the Ethics Guidelines for Trustworthy AI – Independent High-level expert group on
Artificial Intelligence set up by The European Commission. This template may be modified to align to other
frameworks that may be more aligned with the intended use cases.

ETHICS.md to be included in the main repository for NLIP-conforming agents.

# Ethical compliance statement

This template is based on the Ethics Guidelines for Trustworthy AI – Independent High-level expert group on
Artificial Intelligence set up by The European Commission.

---

## 1. Transparency & Disclosure

- Clearly state when users are interacting with an NLIP agent.

- Document what the agent does, what it doesn’t do, and known limitations.

## 2. User Control

- Describe the **off switch or override path** (quit command, opt-out, or human fallback).

- List the configurable default behaviors and how to change them.

## 3. Privacy & Data Handling

- Describe or link to data collection policy.




© Ecma International 2025                                                                                      9
- Explain how personal data is stored, secured, and how users can clear it.



## 4. Fairness & Accessibility

- Confirm testing with diverse inputs (names, languages, demographics) to reduce bias.

- Confirm accessibility practices (clear text, keyboard-friendly, no color-only signals).

## 5. Safety & Robustness

- Confirm inputs/outputs are sanitized to reduce risks of prompt injection, harmful code execution, or malicious
replies.

- Describe safe fallback/error handling when the agent fails.

## 6. Accountability

- Provide link to track ethical or user-experience concerns in Issues or CHANGELOG.

- Encourage contributors to flag privacy, fairness, or safety issues in `CONTRIBUTING.md`.

---

## Contact

For ethical issues, please contact: ethics@[domain].com




10                                                                                          © Ecma International 2025
                                             Bibliography


Ethics Guidelines for Trustworthy AI – Independent High-level expert group on Artificial Intelligence set up by
The European Commission, (April 2019)
[https://www.europarl.europa.eu/cmsdata/196377/AI%20HLEG_Ethics%20Guidelines%20for%20Trustworthy
%20AI.pdf]


NIST Recommended Criteria for Cybersecurity Labelling of Consumer Software, per Executive Order 14028,
Improving the Nation’s Cybersecurity [https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.02042022-1.pdf]




© Ecma International 2025                                                                                   11
© Ecma International 2025
