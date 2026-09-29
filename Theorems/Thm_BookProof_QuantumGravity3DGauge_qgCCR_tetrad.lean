-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

theorem BookProof.QuantumGravity3DGauge.qgCCR_tetrad (Φ : CoreRep 84 D) (mu a nu b : Fin 4) (x : D) :
    qgCoord Φ (idxE mu a) (qgMom Φ (idxE nu b) x) - qgMom Φ (idxE nu b) (qgCoord Φ (idxE mu a) x)
      = (if mu = nu ∧ a = b then Complex.I else 0) • x := by sorry
