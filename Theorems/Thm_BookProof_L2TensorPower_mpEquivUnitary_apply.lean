-- Generated from ChapterL2TensorPowerUnitary.lean — theorem BookProof.L2TensorPower.mpEquivUnitary_apply
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
open BookProof.L2TensorPower

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]
variable (μ ν) in
variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]



open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section



theorem BookProof.L2TensorPower.mpEquivUnitary_apply {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    {μa : Measure α} {μb : Measure β} (f : α → β) (g : β → α) (hf : MeasurePreserving f μa μb)
    (hg : MeasurePreserving g μb μa) (hgf : ∀ x, g (f x) = x) (h : Lp ℂ 2 μb) :
    (mpEquivUnitary f g hf hg hgf h : α → ℂ) =ᵐ[μa] fun x => (h : β → ℂ) (f x) := by sorry
