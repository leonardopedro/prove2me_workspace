-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.classicalSol_hasDerivAt
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.classicalSol_hasDerivAt (x₀ t : ℝ) (ht : 1 - t * x₀ ≠ 0) :
    HasDerivAt (classicalSol x₀) ((classicalSol x₀ t) ^ 2) t := by sorry
