-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsFlow_group
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) :
    nsFlowUnitary d (s + t) = nsFlowUnitary d s * nsFlowUnitary d t := by

  have hcomm : Commute (((s : ℂ) * Complex.I) • nsHamiltonian d)
      (((t : ℂ) * Complex.I) • nsHamiltonian d) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • nsHamiltonian d
      = ((s : ℂ) * Complex.I) • nsHamiltonian d
        + ((t : ℂ) * Complex.I) • nsHamiltonian d := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [nsFlowUnitary, hsum, Matrix.exp_add_of_commute _ _ hcomm]
  rfl
