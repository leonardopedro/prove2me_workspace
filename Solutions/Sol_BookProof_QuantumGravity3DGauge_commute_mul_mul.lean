-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.commute_mul_mul
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
mp only [smul_eq_C_mul]
  by_cases h : j = k
  · subst h; ring
  · rw [if_neg h, if_neg (Ne.symm h)]; ring

theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) : := momOp j (mo
