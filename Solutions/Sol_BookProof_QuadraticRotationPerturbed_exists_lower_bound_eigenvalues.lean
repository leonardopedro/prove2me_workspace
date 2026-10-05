-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.exists_lower_bound_eigenvalues
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.PosDef) :
    ∃ c0 : ℝ, 0 < c0 ∧ ∀ i, c0 ≤ hA.isHermitian.eigenvalues i := by

  classical
  rcases isEmpty_or_nonempty (Fin d) with h | h
  · exact ⟨1, one_pos, fun i => (h.false i).elim⟩
  · have hne : (Finset.univ : Finset (Fin d)).Nonempty := Finset.univ_nonempty
    refine ⟨Finset.univ.inf' hne hA.isHermitian.eigenvalues, ?_,
      fun i => Finset.inf'_le _ (Finset.mem_univ i)⟩
    rw [Finset.lt_inf'_iff]
    exact fun i _ => hA.eigenvalues_pos i
