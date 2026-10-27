-- Generated from ChapterTensorCompleteness.lean — solution of BookProof.ChapterTensorCompleteness.tensorHilbertBasis_repr_apply
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
    (F : Lp ℂ 2 (μ.prod ν)) (p : ι × κ) :
    (tensorHilbertBasis b c).repr F p = (inner ℂ (tensorOf (b p.1) (c p.2)) F : ℂ) := by

  rw [HilbertBasis.repr_apply_apply, coe_tensorHilbertBasis]
