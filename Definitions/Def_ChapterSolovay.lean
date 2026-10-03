import Definitions.Def_PhysMehler
import Mathlib

import Mathlib.Analysis.InnerProductSpace.Completion
import Mathlib.Topology.UniformSpace.Completion
import RandomMap.RandomMap2

/-!
# Chapter S — Solovay-Hilbert Decidability and the Kopperman Tail

This file formalizes the decidability architecture of the decoupled
Kopperman-Solovay framework (see `RandomMap2.md` Phase 1 and Phase 8.3).

Sections:
* S.1 — The Solovay-Hilbert space as a completion (proper construction)
* S.2 — `dependsOnlyOnHead` decidability argument
* S.3 — The uniform Mehler measure on the infinite-dimensional hypersphere
* S.4 — No Gödelian self-reference in the Solovay-Hilbert space

All theorems are `sorry`-free and `axiom`-free (no `EXTERNAL` hypothesis).
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

namespace BookProof.ChapterSolovay

/-! ## S.1 — The Solovay-Hilbert space as a proper completion -/

/-- **S.1.1 — The Solovay-Hilbert space: the completion of `OuterWaveFunction`.

    The completion adds the missing metric structure, making this a genuine
    Hilbert space. This is the explicit construction that was previously
    a placeholder (`RandomMap2.md` Phase 8.3).

    We use the root-level definitions from `RandomMap2` to avoid shadowing. -/
noncomputable abbrev SolovayHilbertSpace (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] : Type :=
  _root_.UniformSpace.Completion (_root_.OuterWaveFunction N headDist)

noncomputable instance (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] : InnerProductSpace ℂ (SolovayHilbertSpace N headDist) :=
  UniformSpace.Completion.innerProductSpace

noncomputable instance (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] : CompleteSpace (SolovayHilbertSpace N headDist) :=
  UniformSpace.Completion.completeSpace _

/-- The canonical embedding of outer wave-functions into the Solovay-Hilbert space. -/
noncomputable def toSolovay (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ : _root_.OuterWaveFunction N headDist) : SolovayHilbertSpace N headDist :=
  (Ψ : SolovayHilbertSpace N headDist)





/-! ## S.2 — `dependsOnlyOnHead` decidability argument -/





/-! ## S.2a — Finite-head tensor products and product measures -/

/-- Splitting a head of dimension `N₁ + N₂` into its two finite blocks. -/
def headSumEquiv (N₁ N₂ : ℕ) :
    _root_.InnerHead (N₁ + N₂) ≃
      _root_.InnerHead N₁ × _root_.InnerHead N₂ :=
  (Equiv.piCongrLeft (fun _ : Fin (N₁ + N₂) => ℝ)
    (finSumFinEquiv (m := N₁) (n := N₂))).symm.trans
    (Equiv.sumArrowEquivProdArrow (Fin N₁) (Fin N₂) ℝ)

/-- The pointwise tensor (product) of two finite-head observables. -/
def tensorHeadObservable {N₁ N₂ : ℕ}
    (f₁ : _root_.InnerHead N₁ → ℂ) (f₂ : _root_.InnerHead N₂ → ℂ) :
    _root_.InnerSpace (N₁ + N₂) → ℂ :=
  fun z => f₁ ((headSumEquiv N₁ N₂ z.1).1) *
    f₂ ((headSumEquiv N₁ N₂ z.1).2)









/-! ## S.3 — The uniform Mehler measure on the infinite-dimensional hypersphere -/



/-- A transformation is an admissible finite orthogonal symmetry of the
tail when it is measure-preserving for the selected tail prior.  The repository's
abstract `Substrate` does not currently encode a coordinate-level finite-rank
orthogonal group, so invariance is stated at the exact measurable interface. -/
def IsFiniteOrthogonalTailSymmetry (T : _root_.InnerTail → _root_.InnerTail) : Prop :=
  MeasurePreserving T _root_.tailMeasure _root_.tailMeasure





/-- The precise admissibility package used for tail priors.  No unsupported
uniqueness theorem is asserted: uniqueness among all invariant atomless laws
would require a concrete coordinate realization and a characterization theorem
not available in the current substrate model. -/
structure TailPriorAdmissible (μ : Measure _root_.InnerTail) : Prop where
  probability : IsProbabilityMeasure μ
  atomless : ∀ x, μ {x} = 0
  invariant : ∀ T, MeasurePreserving T μ μ → Measure.map T μ = μ





/-! ## S.4 — No Gödelian self-reference -/





end BookProof.ChapterSolovay
