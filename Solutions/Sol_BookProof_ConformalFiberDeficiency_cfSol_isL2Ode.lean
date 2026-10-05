-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfSol_isL2Ode
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfSol
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfSol'
import Theorems.Thm_BookProof_ConformalFiberDeficiency_memLp_cfSol
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsL2Ode cfV Complex.I cfSol := ⟨fun y => cfLog' y * cfSol y, hasDerivAt_cfSol, hasDerivAt_cfSol', memLp_cfSol⟩
