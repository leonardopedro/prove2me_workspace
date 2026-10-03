-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.tendsto_phaseUnitary
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NsLagrangianDet
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.tendsto_phaseUnitary (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by sorry
