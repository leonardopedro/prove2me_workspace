-- Generated from ChapterAbelianVonNeumannFinite.lean — solution of BookProof.ChapterAbelianVonNeumannFinite.commutant_eq_range_conjDiagonal
import Mathlib
import Definitions.Def_ChapterAbelianVonNeumannFinite
import Theorems.Thm_BookProof_ChapterAbelianVonNeumannFinite_commutes_diagonal_iff
open BookProof.ChapterAbelianVonNeumannFinite



open Matrix


variable {n : Type*} [Fintype n] [DecidableEq n]

variable {n : Type*} [Fintype n] [DecidableEq n]

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix n n ℂ} (hA : A.IsHermitian)
    (hdist : Function.Injective hA.eigenvalues) :
    {M : Matrix n n ℂ | M * A = A * M} = Set.range (conjDiagonal hA.eigenvectorUnitary) := by

  classical
  set c := Unitary.conjStarAlgAut ℂ (Matrix n n ℂ) hA.eigenvectorUnitary with hc
  set e : n → ℂ := RCLike.ofReal ∘ hA.eigenvalues with he
  have hAeq : A = c (diagonal e) := hA.spectral_theorem
  have heinj : Function.Injective e := by
    intro i j hij
    exact hdist (by simpa [he, Complex.ofReal_inj] using hij)
  ext M
  simp only [Set.mem_setOf_eq, Set.mem_range]
  constructor
  · intro h
    have h' : c.symm M * diagonal e = diagonal e * c.symm M := by
      have h1 : c.symm (M * A) = c.symm M * c.symm A := map_mul _ _ _
      have h2 : c.symm (A * M) = c.symm A * c.symm M := map_mul _ _ _
      have hcA : c.symm A = diagonal e := by rw [hAeq]; exact c.symm_apply_apply _
      rw [hcA] at h1 h2
      rw [← h1, ← h2, h]
    obtain ⟨d, hd⟩ := (commutes_diagonal_iff e heinj (c.symm M)).1 h'
    refine ⟨d, ?_⟩
    rw [conjDiagonal_apply, ← hc, ← hd, c.apply_symm_apply]
  · rintro ⟨d, rfl⟩
    have hcomm : diagonal d * diagonal e = diagonal e * diagonal d := by
      rw [diagonal_mul_diagonal, diagonal_mul_diagonal]
      simp [mul_comm]
    have hc2 := congrArg c hcomm
    rw [map_mul, map_mul] at hc2
    rw [conjDiagonal_apply, ← hc, hAeq]
    exact hc2
