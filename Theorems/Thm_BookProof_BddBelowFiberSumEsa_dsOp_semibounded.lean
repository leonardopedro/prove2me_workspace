-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.dsOp_semibounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.DirectSumEsa
open BookProof.WallEsaSemibounded
open BookProof.BddBelowFiberSumEsa

variable {ι : Type*}



open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section


namespace BookProof.BddBelowFiberSumEsa

open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section


theorem BookProof.BddBelowFiberSumEsa.dsOp_semibounded (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, ∃ K : ℝ, ∀ x, -K ≤ V i x) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) := by
  refine dsOp_essentiallySelfAdjointOn _ (fun i => ?_)
  obtain ⟨K, hK⟩ := hbdd i
  exact wallHam_essentiallySelfAdjoint_of_bddBelow (V i) (hV i) hK

/-- The same with the fibre hypotheses phrased as `BddBelow (Set.range (V i))`. -/
theorem fiberSumHam_essentiallySelfAdjoint_of_bddBelow_prime (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, BddBelow (Set.range (V i))) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) := by
  refine fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV (fun i => ?_)
  obtain ⟨c, hc⟩ := hbdd i
  exact ⟨-c, fun x => by simpa using hc ⟨x, rfl⟩⟩

/-- The non-negative case. -/
theorem fiberSumHam_essentiallySelfAdjoint_of_nonneg (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i)) (hnn : ∀ i x, 0 ≤ V i x) :
    EssentiallySelfAdjointOn (fiberCore ι) (fiberSumHam V hV) :=
  fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV
    (fun i => ⟨0, fun x => by simpa using hnn i x⟩)

/-- **The unitary flow of the composed operator.** -/
theorem fiberSumHam_stone_flow (V : ι → ℝ → ℝ)
    (hV : ∀ i, ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (V i))
    (hbdd : ∀ i, ∃ K : ℝ, ∀ x, -K ≤ V i x) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint (fiberSpace ι))
      (U : ℝ → (fiberSpace ι →L[ℂ] fiberSpace ι)),
      EsaClosure.IsSelfAdjointExtension (fiberSumHam V hV) T.op ∧ StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ fiberCore_dense (fiberSumHam_symmetricOn V hV)
    (fiberSumHam_essentiallySelfAdjoint_of_bddBelow V hV hbdd)

/-! ## The quadratic form of the composed operator -/

/-- **A fibrewise lower bound on the quadratic forms glues.**  If every fibre form is bounded
below by the *same* constant `−c`, so is the form of the direct sum: both the pairing and the
norm square of a vector of the glued core are the (finite) sums of their fibre values. -/
theorem dsOp_semibounded {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}
    (H : ∀ i, D i →ₗ[ℂ] G i) {c : ℝ} (h : ∀ i, SemiboundedBelowOn (D i) (H i) c) :
    SemiboundedBelowOn (dsCore D) (dsOp H) c := by sorry
