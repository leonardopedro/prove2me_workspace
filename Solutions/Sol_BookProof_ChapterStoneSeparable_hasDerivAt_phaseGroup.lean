-- Generated from ChapterStoneSeparable.lean — solution of BookProof.ChapterStoneSeparable.hasDerivAt_phaseGroup
import Mathlib
import Definitions.Def_ChapterStoneSeparable
import Theorems.Thm_BookProof_ChapterUnboundedPosition_tendsto_slope_phaseUnitary
open BookProof.ChapterStoneSeparable



open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterStoneResolvent BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  [TopologicalSpace.SeparableSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (x : (mulSA f).domain) :
    HasDerivAt (fun t : ℝ => (phaseGroup f).U t (x : L2Z))
      ((-Complex.I) • (mulSA f).op x) 0 := by

  have hd : HasDerivAt (fun t : ℝ => (phaseUnitary f t (x : L2Z) : L2Z))
      (Complex.I • mulOp f x) (-0 : ℝ) := by
    rw [neg_zero, hasDerivAt_iff_tendsto_slope]
    refine (tendsto_slope_phaseUnitary f x).congr fun t => ?_
    simp [slope, phaseLin_zero]
  have hneg : HasDerivAt (fun t : ℝ => -t) (-1 : ℝ) 0 := by
    simpa using hasDerivAt_neg (0 : ℝ)
  have h2 := hd.scomp (0 : ℝ) hneg
  simp [neg_smul, neg_one_smul] at h2 ⊢
  exact h2
