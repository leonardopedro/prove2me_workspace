-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.tendsto_slope_phaseUnitary
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.NsLagrangianDet
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.tendsto_slope_phaseUnitary (f : ℤ → ℝ) (psi : mulDomain f) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • mulOp f psi)) := by sorry
