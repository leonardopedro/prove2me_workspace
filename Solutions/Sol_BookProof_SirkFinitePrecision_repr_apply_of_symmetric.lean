-- Generated from ChapterSirkFinitePrecision.lean — solution of BookProof.SirkFinitePrecision.repr_apply_of_symmetric
import Mathlib
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision







noncomputable section


open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution {T : E →ₗ[ℂ] E} (hT : T.IsSymmetric)
    (hn : Module.finrank ℂ E = n) (x : E) (i : Fin n) :
    coeff hT hn (T x) i = (hT.eigenvalues hn i : ℂ) * coeff hT hn x i := by

  rw [coeff, coeff, OrthonormalBasis.repr_apply_apply, OrthonormalBasis.repr_apply_apply,
    ← hT, hT.apply_eigenvectorBasis hn i, inner_smul_left]
  simp
