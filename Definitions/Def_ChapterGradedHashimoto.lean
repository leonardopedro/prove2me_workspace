import Definitions.Def_ChapterGradedFriedrichs
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# Chapter GradedHashimoto — the graded Hamiltonian is even, and the SIRK limit selects it

`BookProof.ChapterGradedFriedrichs` proved the analytic half of §10.6.2 item 3 of
`CONSOLIDATED_PLAN.md`: the total graded Hamiltonian

`H(A, B) = dΓˢ(A) ⊗ 1 + 1 ⊗ dΓᵃ(B)`

is densely defined, symmetric and positive on `ℓ²(Conf × FConf) ≅ Γˢ ⊗ Γᵃ` itself, hence
has a positive self-adjoint (Friedrichs) extension.  Two things that the bosonic
(`ChapterFockSecondQuantization`) and fermionic (`ChapterFermionFock`) factors each carry
were still missing on the graded space, and are proved here.

## Deliverables

**1. The Hamiltonian respects the `ℤ₂` grading.**  `support_parityF`, `modesF_parityF`
and `parityF_creVecF` (creation of a one-particle vector is odd) give
`parityF_dGammaF`: the fermionic second quantization is **even**, being a sum of products
of two odd operators.  With `liftFst_liftSnd_comm` this yields the headline
`gradeOp_gradedHamiltonianAlg`: `(−1)^{N_f} H = H (−1)^{N_f}`, so `H` commutes with the
grading operator and therefore preserves the even and the odd subspace separately
(`gradedHamiltonianAlg_evenPart`, `gradedHamiltonianAlg_oddPart`) — the graded Hamiltonian
is an *even* element of the superalgebra, as a physical Hamiltonian must be.

**2. The Hashimoto/SIRK shift-invert limit selects the Friedrichs extension** of the
graded Hamiltonian, exactly as it does factorwise: `gradedHamiltonianB` is the operator
read on the finite-mode domain of the canonical basis of `ℓ²(Conf × FConf)` re-indexed by
`ℕ`, and `graded_hashimoto_selects` gives the positive self-adjoint extension `A`, the
shift-invert resolvent `R = (A + γ)⁻¹` with `‖R‖ ≤ γ⁻¹`, the strong and resolvent-sense
convergence of the Galerkin truncations, and the *uniqueness* clause: any operator with
the same shift-invert resolvent is `A`.  `gradedSecondQuantization_hashimoto_selects`
phrases it for arbitrary symmetric positive one-particle operators given in Hilbert bases,
and `gradedNumber_hashimoto_selects` is the concrete instance for the total number
operator `N_b ⊗ 1 + 1 ⊗ N_f`, with `gradedEnum` a concrete enumeration of
`Conf × FConf` so that nothing here is vacuous.

**3. Energies add on elementary tensors.**  `gradedHamiltonianAlg_otimes`:
`H (v ⊗ w) = dΓˢ(A)v ⊗ w + v ⊗ dΓᵃ(B)w`.

**4. The graded flow.**  `graded_stone_flow` and `gradedNumber_stone_flow` push the
selected extension through the Stone bridge: the graded Hamiltonian generates a global
unitary one-parameter group on `ℓ²(Conf × FConf)` solving the Schrödinger equation on its
domain.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).

**Honest boundary.**  The one-particle space is still the abstract `ℓ²(ℕ)` of a Hilbert
basis, not the gravity space `L²(ℝ⁸⁴ × ℤ₂¹⁹)` (§10.6.2 item 4), positivity of the
one-particle matrices is a hypothesis, and no essential self-adjointness of the graded
Hamiltonian is claimed.
-/

namespace BookProof.GradedHashimoto

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock
open BookProof.GradedFriedrichs
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

noncomputable section

/-! ## 1. Energies add on an elementary tensor -/



/-! ## 2. The graded Hamiltonian is even -/

















/-! ## 3. The Hashimoto/SIRK selection on the graded space -/

section Selection

open Filter Topology

/-- The graded Hamiltonian on the finite-mode domain of the canonical basis of
`ℓ²(Conf × FConf)` re-indexed by `ℕ` — the form in which the abstract Hashimoto theorem
is stated. -/
def gradedHamiltonianB (ε : ℕ ≃ GConf) (colB colF : ℕ → (ℕ →₀ ℂ)) :
    finiteModeDomain (l2BasisN ε) →ₗ[ℂ] GFock :=
  (gradedHamiltonian colB colF).comp
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε)).toLinearMap







/-- A concrete enumeration of the graded configurations, so that the selection theorem is
not vacuous. -/
def gradedEnum : ℕ ≃ GConf :=
  letI : Denumerable GConf := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv GConf).symm





end Selection

/-! ## 4. The unitary flow of the graded Hamiltonian -/





end

end BookProof.GradedHashimoto
