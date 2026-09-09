import Mathlib

/-!
# Chapter B §B.3(b) — the finite-rank singular-value decomposition (N3 residue)

Source: `book.tex` §3 / `FORMALIZATION_ROADMAP.md` §B.3(b) and §0 S3.  The book
factors the (Hilbert–Schmidt) kernel operator `Ψ` as `Ψ = W D U†` with `D ≥ 0`
diagonal and `W, U` unitary.  Following the roadmap's §0 dense-core method, the
analytic content reduces to a **finite-dimensional singular-value decomposition**:
diagonalize `Ψ†Ψ` on the finite-support core with the finite-dimensional spectral
theorem (`Matrix.IsHermitian.spectral_theorem`), take square roots of the
(non-negative) eigenvalues, and complete the partial isometry to a unitary via an
orthonormal-basis extension.

This module discharges that finite-rank core, `denseCore_svd`: every square
matrix over `𝕜 = ℝ` or `ℂ` admits an SVD `A = W · diag(D) · Uᴴ` with `W, U`
unitary and `D ≥ 0`.  Together with `ChapterB3.conditional_operator_identity`
(the B.3c change-of-marginal identity `T p T† = W D U† (p/p₀) U D W†`) this
completes the algebraic SVD layer of §B.3.

* `gram_svd` — the spectral half: `Aᴴ A = U · diag(D²) · Uᴴ` with `U` unitary,
  `D ≥ 0` (spectral theorem + non-negativity of the eigenvalues of the positive
  semidefinite Gram matrix `Aᴴ A`).
* `svd_completion` — the partial-isometry-completion half: from
  `Bᴴ B = diag(D²)` build a unitary `W` with `B = W · diag(D)`.
* `denseCore_svd` — the SVD, assembled from the two halves.

Everything is `sorry`-free and axiom-clean (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterB3b

open Matrix

/-- **Spectral half of the SVD.**  For any square matrix `A`, the Gram matrix
`Aᴴ A` is Hermitian positive semidefinite, so the finite-dimensional spectral
theorem diagonalizes it as `Aᴴ A = U · diag(D²) · Uᴴ` with `U` unitary and the
singular values `D i = √(eigenvalue i) ≥ 0`. -/
theorem gram_svd {𝕜 : Type*} [RCLike 𝕜] {n : ℕ} (A : Matrix (Fin n) (Fin n) 𝕜) :
    ∃ (U : Matrix (Fin n) (Fin n) 𝕜) (D : Fin n → ℝ),
      U ∈ Matrix.unitaryGroup (Fin n) 𝕜 ∧ (∀ i, 0 ≤ D i) ∧
      Aᴴ * A = U * Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2)) * Uᴴ := by
  letI := RCLike.toPartialOrder (K := 𝕜)
  letI := RCLike.toStarOrderedRing (K := 𝕜)
  have hps : (Aᴴ * A).PosSemidef := Matrix.posSemidef_conjTranspose_mul_self A
  have hH : (Aᴴ * A).IsHermitian := hps.1
  refine ⟨(hH.eigenvectorUnitary : Matrix (Fin n) (Fin n) 𝕜),
    (fun i => Real.sqrt (hH.eigenvalues i)), hH.eigenvectorUnitary.2,
    (fun i => Real.sqrt_nonneg _), ?_⟩
  have hmf : Aᴴ * A = (hH.eigenvectorUnitary : Matrix (Fin n) (Fin n) 𝕜)
        * Matrix.diagonal (RCLike.ofReal ∘ hH.eigenvalues)
        * (hH.eigenvectorUnitary : Matrix (Fin n) (Fin n) 𝕜)ᴴ := by
    have h := hH.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply, Matrix.star_eq_conjTranspose] at h
    exact h
  have hdiag : Matrix.diagonal (RCLike.ofReal ∘ hH.eigenvalues)
      = Matrix.diagonal (fun i => ((Real.sqrt (hH.eigenvalues i) : 𝕜) ^ 2)) := by
    apply congrArg
    ext i
    simp only [Function.comp_apply]
    have hnn : (0:ℝ) ≤ hH.eigenvalues i := hps.eigenvalues_nonneg i
    rw [show ((Real.sqrt (hH.eigenvalues i) : 𝕜) ^ 2)
          = ((Real.sqrt (hH.eigenvalues i) ^ 2 : ℝ) : 𝕜) by push_cast; ring,
        Real.sq_sqrt hnn]
  rw [hdiag] at hmf
  exact hmf

/-
**Partial-isometry-completion half of the SVD.**  If a square matrix `B`
satisfies `Bᴴ B = diag(D²)` with `D ≥ 0`, then its columns are orthogonal with
squared norms `D i²`; normalizing the nonzero columns and completing the family
to an orthonormal basis (`Orthonormal.exists_orthonormalBasis_extension_of_card_eq`)
yields a unitary `W` with `B = W · diag(D)`.
-/
set_option maxHeartbeats 400000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
theorem svd_completion {𝕜 : Type*} [RCLike 𝕜] {n : ℕ}
    (B : Matrix (Fin n) (Fin n) 𝕜) (D : Fin n → ℝ) (_hD : ∀ i, 0 ≤ D i)
    (hBB : Bᴴ * B = Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2))) :
    ∃ W ∈ Matrix.unitaryGroup (Fin n) 𝕜,
      B = W * Matrix.diagonal (fun i => (D i : 𝕜)) := by
  -- Columns `col j := fun i => B i j`; support set `s := {j | D j ≠ 0}`.
  set s : Set (Fin n) := {j | D j ≠ 0};
  -- Define `v : Fin n → E` by `v j := (D j : 𝕜)⁻¹ • col j`.
  obtain ⟨v, hv⟩ : ∃ v : Fin n → EuclideanSpace 𝕜 (Fin n),
      ∀ j ∈ s, ∀ i, v j i = (D j : 𝕜)⁻¹ * B i j := by
    exact ⟨ fun j => WithLp.toLp 2 fun i => ( D j : 𝕜 ) ⁻¹ * B i j, fun j hj i => rfl ⟩;
  -- Show that `v` is orthonormal on `s`.
  have hv_orthonormal : Orthonormal 𝕜 (s.restrict v) := by
    have hv_inner : ∀ i j, i ∈ s → j ∈ s → inner 𝕜 (v i) (v j) = if i = j then 1 else 0 := by
      intro i j hi hj
      have h_inner : inner 𝕜 (v i) (v j) = (D i : 𝕜)⁻¹ * (D j : 𝕜)⁻¹ * (Bᴴ * B) i j := by
        simp [ hv i hi, hv j hj, Matrix.mul_apply, inner ];
        simp only [mul_comm, mul_left_comm, mul_assoc, Finset.mul_sum _ _ _];
      by_cases hij : i = j <;> simp_all [ sq, mul_assoc, mul_comm ];
      simp [ hj.out ];
    simp_all [ orthonormal_iff_ite ];
  -- Extend `v` to an orthonormal basis `e` of `E`.
  obtain ⟨e, he⟩ : ∃ e : OrthonormalBasis (Fin n) 𝕜 (EuclideanSpace 𝕜 (Fin n)),
      ∀ j ∈ s, e j = v j := by
    convert Orthonormal.exists_orthonormalBasis_extension_of_card_eq _ hv_orthonormal;
    simp ;
  refine ⟨ Matrix.of ( fun i j => e j i ), ?_, ?_ ⟩ <;>
    simp_all only [mem_unitaryGroup_iff']
  · ext i j
    simp only [mul_apply, star_apply, of_apply, RCLike.star_def]
    have := e.orthonormal
    rw [ orthonormal_iff_ite ] at this
    convert this i j using 1
    ac_rfl
  · ext i j
    by_cases hj : D j = 0 <;>
      simp_all only [mul_apply, of_apply, diagonal_apply, map_zero, ite_self, mul_zero,
        Finset.sum_const_zero, mul_ite, Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte]
    · replace hBB := congr_fun ( congr_fun hBB j ) j
      simp_all [ Matrix.mul_apply, Matrix.diagonal ]
      simp_all [ mul_comm, RCLike.mul_conj ]
      norm_cast at hBB
      simp_all [ Finset.sum_eq_zero_iff_of_nonneg ]
    · rw [ he j hj, hv j hj i, inv_mul_eq_div, div_mul_cancel₀ _ ( by simpa ) ]

/-- **Finite-rank singular value decomposition (`denseCore_svd`).**  Every square
matrix `A` over `𝕜 ∈ {ℝ, ℂ}` factors as `A = W · diagonal D · Uᴴ` with `W, U`
unitary and the singular values `D i ≥ 0` real and non-negative.

This is the finite-dimensional core of the book's `Ψ = W D U†` (§B.3(b)); under
the §0 dense-core method it is all that is needed (no infinite-dimensional
compact-operator spectral theory). -/
theorem denseCore_svd {𝕜 : Type*} [RCLike 𝕜] {n : ℕ} (A : Matrix (Fin n) (Fin n) 𝕜) :
    ∃ (W U : Matrix (Fin n) (Fin n) 𝕜) (D : Fin n → ℝ),
      W ∈ Matrix.unitaryGroup (Fin n) 𝕜 ∧
      U ∈ Matrix.unitaryGroup (Fin n) 𝕜 ∧
      (∀ i, 0 ≤ D i) ∧
      A = W * Matrix.diagonal (fun i => (D i : 𝕜)) * Uᴴ := by
  obtain ⟨U, D, hU, hD, hAA⟩ := gram_svd A
  have hUUH : U * Uᴴ = 1 := by
    have h := (Matrix.mem_unitaryGroup_iff).mp hU
    rwa [Matrix.star_eq_conjTranspose] at h
  have hUHU : Uᴴ * U = 1 := by
    have h := (Matrix.mem_unitaryGroup_iff').mp hU
    rwa [Matrix.star_eq_conjTranspose] at h
  -- `B := A * U` satisfies `Bᴴ B = diag(D²)`.
  have hBB : (A * U)ᴴ * (A * U) = Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2)) := by
    rw [Matrix.conjTranspose_mul]
    calc Uᴴ * Aᴴ * (A * U)
        = Uᴴ * (Aᴴ * A) * U := by
          simp only [Matrix.mul_assoc]
      _ = Uᴴ * (U * Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2)) * Uᴴ) * U := by rw [hAA]
      _ = (Uᴴ * U) * Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2)) * (Uᴴ * U) := by
          simp only [Matrix.mul_assoc]
      _ = Matrix.diagonal (fun i => ((D i : 𝕜) ^ 2)) := by rw [hUHU]; simp
  obtain ⟨W, hW, hBW⟩ := svd_completion (A * U) D hD hBB
  refine ⟨W, U, D, hW, hU, hD, ?_⟩
  have hstep : A * U * Uᴴ = W * Matrix.diagonal (fun i => (D i : 𝕜)) * Uᴴ := by rw [hBW]
  rwa [Matrix.mul_assoc, hUUH, Matrix.mul_one] at hstep

end BookProof.ChapterB3b
