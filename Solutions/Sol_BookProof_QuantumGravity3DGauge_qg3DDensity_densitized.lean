-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qg3DDensity_densitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravityDensitized_conformal_absorption
import Theorems.Thm_BookProof_QuantumGravityDensitized_kinetic_absorption
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (e s p : ℝ) (he : 0 < e) :
    qg3DDensity e s p = 1 / 16 * (s / densY e) ^ 2 - 1 / 24 * (p / densY e) ^ 2 := he densitized form of the
