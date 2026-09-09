import Mathlib
import BookProof.ChapterNavierStokesFullEsa
import BookProof.ChapterNavierStokesLagrangianKatoRellich
import BookProof.ChapterNavierStokesFockEsa
import BookProof.ChapterNavierStokesMomentumEsa
import BookProof.ChapterNavierStokesIkebeKato
import BookProof.ChapterNavierStokesDiffFarisLavine
import BookProof.ChapterNavierStokesDiffHashimoto
import BookProof.ChapterNsOuterFockSingleTime
import BookProof.ChapterNsTimeIndependentFlow

/-!
# Chapter NavierStokesEsaConsolidation — the Navier–Stokes self-adjointness statements of
# record, in one place

`CONSOLIDATED_PLAN.md` (2026-09-04f), NS next step 2: *"A consolidation chapter.  The ESA
statements of record are spread over five realizations (Eulerian-conditional + sharp
negative, Lagrangian Kato–Rellich, Fock-of-Fock unconditional, momentum, differential).  One
chapter stating the per-realization theorems and the change-of-variables transfers lets
everything downstream import once."*

This chapter is that index.  It proves nothing new: every entry is the headline of one of
the realization chapters, re-exported here under a uniform name, so that a downstream
module needs a single import and a single namespace.  The point of the chapter is the
**map**: which realization is unconditional, which is conditional and on what, what the
sharp negative rules out, and which transfers carry a result from one realization to
another.

## The map

* **Eulerian, untruncated** — symmetric unconditionally (`nsEulerian_symmetric`); ESA
  *conditional* on a complete unitary flow (`nsEulerian_esa_of_completeFlow`) or on a total
  family of eigenvectors (`nsEulerian_esa_of_totalEigenvectors`); and the sharp negative
  (`nsEulerian_not_esa_in_general`), which rules out any purely structural proof.
* **Lagrangian** — the Kato–Rellich transfer (`nsLagrangian_esa_of_katoRellich`) and the
  Hashimoto selection (`nsLagrangian_hashimoto_selects`).
* **Fock of Fock** — ESA unconditionally (`nsFockOfFock_esa`), with the transfer back to the
  Eulerian data (`nsEulerian_esa_of_fockLagrangian`).
* **Momentum** — ESA from the two Faris–Lavine inequalities
  (`nsMomentum_esa_of_farisLavine`), with the Ikebe–Kato comparison operator
  (`nsMomentum_comparison_ikebeKato`).
* **Differential on `L²(ℝ³)`** — ESA unconditionally (`nsDifferential_esa`), the same by
  Faris–Lavine (`nsDifferential_esa_farisLavine`), and the Hashimoto multishift selection
  (`nsDifferential_hashimoto_selects`).
* **Outer Fock (parcels)** — ESA with the interaction terms (`nsOuterFock_esa`) and the
  single-time package (`nsOuterFock_singleTime`).
* **Single-time packages** of the remaining realizations: `nsEulerian_singleTime`,
  `nsGaugeY_singleTime`, `nsLagrangian_singleTime`.

## Honest boundary

The scope cut recorded as Contention D5 is unchanged: **no global regularity of the
classical Navier–Stokes PDE is claimed anywhere**, and the advection of the quadratic
realizations is the Oseen linearisation with a background velocity field.  What this chapter
collects are operator-theoretic statements — self-adjointness of the quantized generator in
each realization, and the transfers between them.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NavierStokesFlow.EsaConsolidation

/-! ## 1. The Eulerian (untruncated) realization -/

/-- The untruncated Eulerian Navier–Stokes Hamiltonian is symmetric, unconditionally. -/
alias nsEulerian_symmetric :=
  BookProof.NavierStokesFlow.FullEsa.NSFullData.hamiltonian_isSymmetricDom

/-- Essential self-adjointness of the untruncated Eulerian Hamiltonian, **conditional** on a
complete unitary flow (Nelson's criterion). -/
alias nsEulerian_esa_of_completeFlow :=
  BookProof.NavierStokesFlow.FullEsa.NSFullData.hasZeroDeficiencyOn_of_completeUnitaryFlow

/-- Essential self-adjointness of the untruncated Eulerian Hamiltonian, **conditional** on a
total family of common eigenvectors. -/
alias nsEulerian_esa_of_totalEigenvectors :=
  BookProof.NavierStokesFlow.FullEsa.NSFullData.hasZeroDeficiencyOn_of_total_eigenvectors

/-- **The sharp negative.**  There is untruncated Navier–Stokes data whose full Hamiltonian
is *not* essentially self-adjoint, so the conditional form of the two entries above is not
an artefact of the proof: an analytic input is indispensable. -/
alias nsEulerian_not_esa_in_general :=
  BookProof.NavierStokesFlow.FullEsa.exists_nsFullData_not_hasZeroDeficiencyOn

/-! ## 2. The Lagrangian realization: Kato–Rellich, and the Hashimoto selection -/

/-- **The Kato–Rellich transfer.**  Under a unitary change of variables onto Lagrangian
data whose drift is bounded relative to the positive second-order part, essential
self-adjointness of that second-order part gives it for the Eulerian Hamiltonian. -/
alias nsLagrangian_esa_of_katoRellich :=
  BookProof.NavierStokesFlow.LagrangianKatoRellich.hasZeroDeficiencyOn_of_lagrangian_katoRellich

/-- The Hashimoto/SIRK shift-invert limit selects the Lagrangian realization. -/
alias nsLagrangian_hashimoto_selects :=
  BookProof.NavierStokesFlow.LagrangianKatoRellich.lagrangian_hashimoto_selects

/-! ## 3. The Fock-of-Fock realization: unconditional -/

/-- **Unconditional essential self-adjointness** of the transformed full Hamiltonian on the
Fock space of a Fock space. -/
alias nsFockOfFock_esa :=
  BookProof.NavierStokesFlow.FockOfFock.lagrangianFock_hasZeroDeficiencyOn

/-- **The transfer back.**  A unitary change of variables carrying Eulerian data onto the
second-quantized Lagrangian data makes the Eulerian Hamiltonian essentially self-adjoint. -/
alias nsEulerian_esa_of_fockLagrangian :=
  BookProof.NavierStokesFlow.FockOfFock.nsFullData_hasZeroDeficiencyOn_of_fockLagrangian

/-! ## 4. The momentum realization -/

/-- Essential self-adjointness of the momentum-representation Hamiltonian on the finite-mode
core, from the relative bound and the commutator bound (Faris–Lavine). -/
alias nsMomentum_esa_of_farisLavine :=
  BookProof.NavierStokesFlow.MomentumEsa.ns_hamiltonian_essentiallySelfAdjointOn_core

/-- The Ikebe–Kato comparison operator of the momentum realization is essentially
self-adjoint on the finite-mode core. -/
alias nsMomentum_comparison_ikebeKato :=
  BookProof.NavierStokesFlow.IkebeKato.ikebeKato_momentum

/-! ## 5. The differential realization on `L²(ℝ³)` -/

/-- **Unconditional essential self-adjointness** of the differential Navier–Stokes symbol on
the Gauss–polynomial core of `L²(ℝ³)`. -/
alias nsDifferential_esa :=
  BookProof.NavierStokesFlow.DifferentialL2.nsDiffH_essentiallySelfAdjointOn_core

/-- The same, by the two differential Faris–Lavine inequalities. -/
alias nsDifferential_esa_farisLavine :=
  BookProof.NavierStokesFlow.DiffFarisLavine.nsDiffH_esa_of_farisLavine

/-- The Hashimoto multishift limit selects the differential realization. -/
alias nsDifferential_hashimoto_selects :=
  BookProof.NavierStokesFlow.DiffHashimoto.nsDiffH_hashimoto_selects

/-! ## 6. The outer-Fock (parcel) realization, with the interaction terms -/

/-- **Essential self-adjointness with the interaction terms**: the gauge-fixed Navier–Stokes
Hamiltonian on the outer Fock space `⊕ₙ L²(ℝ^{18n})`, by Faris–Lavine on the domain of the
lifted Friedrichs comparison operator. -/
alias nsOuterFock_esa :=
  BookProof.NsOuterFock.nsOuterFock_esa_farisLavine

/-- **One shift, one finite time** for the outer-Fock realization: the generator carries no
time dependence and the particle-number truncations converge, in the Hashimoto shift-invert
sense at every nonzero shift and in the propagator sense at every single finite time. -/
alias nsOuterFock_singleTime :=
  BookProof.NsOuterFock.nsOuterFock_timeIndependent_singleTime

/-! ## 7. The single-time packages of the remaining realizations -/

/-- One shift, one finite time for the Eulerian fibre realization. -/
alias nsEulerian_singleTime :=
  BookProof.NsTimeIndependent.nsEulerian_timeIndependent_singleTime

/-- One shift, one finite time for the `y`-gauge realization. -/
alias nsGaugeY_singleTime :=
  BookProof.NsTimeIndependent.nsGaugeY_timeIndependent_singleTime

/-- One shift, one finite time for the Lagrangian fibre realization. -/
alias nsLagrangian_singleTime :=
  BookProof.NsTimeIndependent.nsLagrangian_timeIndependent_singleTime

end BookProof.NavierStokesFlow.EsaConsolidation
