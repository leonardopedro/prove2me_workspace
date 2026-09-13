-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.nsFlowEuclidean_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

















variable {ι : Type*}









open BookProof.ChapterContinuityUnitaryInfinite














variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (psi : EuclideanSpace ℂ (Fin n)) (t : ℝ) :
    HasDerivAt (fun s : ℝ => nsFlowEuclidean d s psi)
      (Complex.I • Matrix.toEuclideanLin (nsHamiltonian d) (nsFlowEuclidean d t psi)) t := by

  have h := nsFlow_solves_schrodinger d (WithLp.ofLp psi) t
  have h2 := ((((PiLp.continuousLinearEquiv 2 ℂ
      (fun _ : Fin n => ℂ)).symm.toContinuousLinearMap).restrictScalars
      ℝ).hasFDerivAt).comp_hasDerivAt t h
  have heq : Complex.I • Matrix.toEuclideanLin (nsHamiltonian d) (nsFlowEuclidean d t psi)
      = WithLp.toLp 2
        ((Complex.I • nsHamiltonian d) *ᵥ (nsFlowUnitary d t *ᵥ WithLp.ofLp psi)) := by
    ext i
    simp [nsFlowEuclidean, Matrix.smul_mulVec]
  rw [heq]
  simpa [Function.comp_def, nsFlowEuclidean] using h2
