-- Generated from ChapterTensorCompleteness.lean — solution of BookProof.ChapterTensorCompleteness.hasSum_sq_norm_inner_tensorHilbertBasis
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
open BookProof.ChapterTensorCompleteness



noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
variable {ι κ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution
    (b : HilbertBasis ι ℂ (Lp ℂ 2 μ)) (c : HilbertBasis κ ℂ (Lp ℂ 2 ν))
    (F : Lp ℂ 2 (μ.prod ν)) :
    HasSum (fun p : ι × κ => ‖(inner ℂ (tensorOf (b p.1) (c p.2)) F : ℂ)‖ ^ 2) (‖F‖ ^ 2) := by

  have h := (tensorHilbertBasis b c).hasSum_inner_mul_inner F F
  rw [← Complex.hasSum_ofReal]
  have hcast : ∀ p : ι × κ,
      ((‖(inner ℂ (tensorOf (b p.1) (c p.2)) F : ℂ)‖ ^ 2 : ℝ) : ℂ)
        = (inner ℂ F ((tensorHilbertBasis b c) p) : ℂ)
            * (inner ℂ ((tensorHilbertBasis b c) p) F : ℂ) := by
    intro p
    rw [coe_tensorHilbertBasis, ← inner_conj_symm (𝕜 := ℂ) (tensorOf (b p.1) (c p.2)) F,
      RCLike.norm_conj]
    push_cast
    exact (RCLike.mul_conj (K := ℂ) (inner ℂ F (tensorOf (b p.1) (c p.2)))).symm
  have h2 : ((‖F‖ ^ 2 : ℝ) : ℂ) = (inner ℂ F F : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K (𝕜 := ℂ)]
    norm_cast
  rw [h2]
  simpa only [hcast] using h
