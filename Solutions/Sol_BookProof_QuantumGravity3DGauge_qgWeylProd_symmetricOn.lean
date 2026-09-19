-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgWeylProd_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgWeylProd_coord_mom_polySym
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 84 D) (j k : Fin 84) :
    SymmetricOn D (D.subtype.comp (Φ.op (qgWeylProd (mulOp (X j)) (momOp k)))) := Φ.symmetricOn_op (qgWeylProd_coord_mom_polySym j k)
