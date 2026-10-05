-- Generated from ChapterL2TensorPowerUnitary.lean — solution of BookProof.L2TensorPower.mpEquivUnitary_apply
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
open BookProof.L2TensorPower




open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section


variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]
variable (μ ν) in
variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]

set_option maxHeartbeats 1000000 in
theorem solution {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    {μa : Measure α} {μb : Measure β} (f : α → β) (g : β → α) (hf : MeasurePreserving f μa μb)
    (hg : MeasurePreserving g μb μa) (hgf : ∀ x, g (f x) = x) (h : Lp ℂ 2 μb) :
    (mpEquivUnitary f g hf hg hgf h : α → ℂ) =ᵐ[μa] fun x => (h : β → ℂ) (f x) := Lp.coeFn_compMeasurePreserving h hf
