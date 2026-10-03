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
theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulOp (X j) (momOp k p) - momOp k (mulOp (X j) p) = (if j = k then Complex.I else 0) • p :=
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
