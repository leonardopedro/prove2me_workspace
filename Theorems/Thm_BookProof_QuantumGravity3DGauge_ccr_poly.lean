-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.ccr_poly
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

al = nu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, hnu, ha]

theorem BookProof.QuantumGravity3DGauge.ccr_poly (mu nu a : Fin 4) : idxX mu ≠ idxE nu a := by
  intro h
  have := congrArg Fin.val h
  simp only [idxX, idxE] at this
  omega

theorem idxX_ne_idxDE (mu nu rho a : Fin 4) : idxX mu ≠ idxDE nu rho a := by
  intro h
  have := congrArg := by sorry
