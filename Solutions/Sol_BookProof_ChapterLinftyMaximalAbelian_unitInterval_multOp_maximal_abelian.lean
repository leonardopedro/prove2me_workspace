-- Generated from ChapterLinftyMaximalAbelian.lean — solution of BookProof.ChapterLinftyMaximalAbelian.unitInterval_multOp_maximal_abelian
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Theorems.Thm_BookProof_ChapterLinftyMaximalAbelian_multOp_algebra_maximal_abelian
open BookProof.ChapterLinftyMaximalAbelian



noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

set_option maxHeartbeats 1000000 in
theorem solution
    (T : Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)) →L[ℂ]
      Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)))
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : ℝ → ℂ) (hψ : MemLp ψ ⊤ (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1))),
      T = multOp ψ hψ := multOp_algebra_maximal_abelian T hT
