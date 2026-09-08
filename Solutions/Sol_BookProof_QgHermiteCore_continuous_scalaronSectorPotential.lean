-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.continuous_scalaronSectorPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Theorems.Thm_BookProof_QgHermiteCore_continuous_starobinskyV
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]





































open BookProof.HermiteProductCore

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (V3 : Polynomial ℝ) :
    Continuous (scalaronSectorPotential M alpha V3) := by

  unfold scalaronSectorPotential
  exact (V3.continuous_aeval.comp (by fun_prop)).add
    ((continuous_starobinskyV M alpha).comp (by fun_prop))
