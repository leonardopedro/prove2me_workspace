-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.kinetic_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_NavierStokesFlow_LagrangianNS_sum_sq_posSemidef
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution : L.kinetic.PosSemidef := (sum_sq_posSemidef L.P_herm).smul (by norm_num)
