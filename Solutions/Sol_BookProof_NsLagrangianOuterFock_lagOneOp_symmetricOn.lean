-- Generated from ChapterNsLagrangianOuterFockEsa.lean — solution of BookProof.NsLagrangianOuterFock.lagOneOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsLagrangianOuterFockEsa
open BookProof.NsLagrangianOuterFock




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsNonAbelianEsa
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.IkebeKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    SymmetricOn (lpFiniteModes Vel) (lagOneOp nu hnu f) := lagrangianCore_symmetricOn (lagCanData nu hnu f)
