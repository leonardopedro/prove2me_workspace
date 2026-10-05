-- Generated from ChapterTensorCompleteness.lean — theorem BookProof.ChapterTensorCompleteness.tensorHilbertBasis_repr_apply
import Definitions.Def_ChapterSolovayHilbertTensor
import Mathlib
import Definitions.Def_ChapterTensorCompleteness
open BookProof.ChapterTensorCompleteness

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  {μ : Measure α} {ν : Measure β} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
variable {ι κ : Type*}


noncomputable section

open MeasureTheory ENNReal Complex Filter Topology


open BookProof.ChapterSolovayHilbertTensor


theorem BookProof.ChapterTensorCompleteness.tensorHilbertBasis_repr_apply
    (b : HilbertBasis ι ℂ (Lp ℂ 2 μ)) (c : HilbertBasis κ ℂ (Lp ℂ 2 ν))
    (F : Lp ℂ 2 (μ.prod ν)) (p : ι × κ) :
    (tensorHilbertBasis b c).repr F p = (inner ℂ (tensorOf (b p.1) (c p.2)) F : ℂ) := by sorry
