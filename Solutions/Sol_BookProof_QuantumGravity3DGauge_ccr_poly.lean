-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.ccr_poly
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_YangMillsHermite_commutator_coord_mom
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
al = nu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, hnu, ha]

theorem solution (mu nu a : Fin 4) : idxX mu ≠ idxE nu a := by
  intro h
  have := congrArg Fin.val h
  simp only [idxX, idxE] at this
  omega

theorem idxX_ne_idxDE (mu nu rho a : Fin 4) : idxX mu ≠ idxDE nu rho a := by
  intro h
  have := congrArg :=
   Fin.val h
    simp only [idxX, idxDE] at this
    omega
  
  theorem idxE_ne_idxDE (mu a nu rho b : Fin 4) : idxE mu a ≠ idxDE nu rho b := by
    intro h
    have := congrArg Fin.val h
    simp only [idxE, idxDE] at this
    omega
  
  /-! ## F.3 — the canonical commutation relations at polynomial level -/
  
  variable {d : ℕ}
  
  /--
