-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.idxX_ne_idxDE
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (mu a nu rho b : Fin 4) : idxE mu a ≠ idxDE nu rho b :=
   q.2.1 q.2.2) := by
    rintro ⟨mu, nu, a⟩ ⟨mu', nu', a'⟩ h
    have h' := congrAr
