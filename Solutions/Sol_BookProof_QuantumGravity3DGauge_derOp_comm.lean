-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.derOp_comm
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_pderiv_comm_poly
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    pderiv j (pderiv k p) = pderiv k (pderiv j p) :=
  neg_smul, smul_eq_C_mul]
      ring
  
  /-- Second partial derivatives commute. -/
  theorem pderiv_comm_poly (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
      pderiv j (pderiv k p) = pderiv k (pderiv j p) := by
    classical
    induction p using MvPolynomial.induction_on with
    | C a => simp
    | add p q hp hq => simp [hp, hq]
    | mul_X p i hp =>
        simp only [pderiv_mul, MvPolynomial.pderiv_X, Pi.single_apply, map_add, hp]
        split_ifs with h1 h2 h2 <;> (simp; try ring)
  
  /-- The **first-order derivative operators commute**: `[∂_j − x_j/2, ∂_k − x_k/2] = 0`. -/
  theorem derOp_comm (j k : Fin d) (p :
