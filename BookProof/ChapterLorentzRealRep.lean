import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterPinOmega

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", **Lemma 52** — concrete real
irreducible representations of `SL(2,C)`

`book.tex` (Lemma 52, line ~5560) classifies the finite-dimensional real
irreducible representations of `SL(2,C)` and gives three explicit examples in the
`4×4` Majorana matrix model, on which the spin group acts by conjugation
`M(S)(A) = S A S†`:

* the **`(1/2,1/2)` vector representation** — the real span of
  `{1, γ⁰γ¹, γ⁰γ², γ⁰γ³}` (a `1 + 3` vector, dimension `4`);
* the **`(1,0)` representation** — the real span of
  `{iγ¹, iγ², iγ³, γ¹γ⁵, γ²γ⁵, γ³γ⁵}` (dimension `6`);
* the **pseudo-`(1/2,1/2)` representation** — the real span of
  `{iγ⁵, iγ⁵γ¹γ⁰, iγ⁵γ²γ⁰, iγ⁵γ³γ⁰}` (dimension `4`).

Here we discharge the concrete, self-contained core over the discrete `Pin(3,1)`
subgroup `Ω = {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵}` (the quaternion group `Q₈` of
`BookProof.ChapterPinOmega`, whose image under the covering map `Λ` is the
Klein-four discrete Lorentz group `Δ`).  For each of the three example spaces we
prove:

* **conjugation invariance** — conjugation by every `S ∈ Ω` maps each basis matrix
  to `±` a basis matrix (a *signed permutation* of the basis), decidably over `ℤ`;
* **dimension** — the basis matrices are linearly independent over `ℝ` (their
  Frobenius Gram matrix is `4·I`), so the representation spaces have dimensions
  `4`, `6`, `4`;
* **`Submodule` invariance** — the real span is carried into itself by the
  conjugation map `A ↦ S A S⁻¹`, for every `S ∈ Ω`.

All the finite/entrywise facts are closed over `ℤ` by `decide` and transported to
`ℝ` through `Int.castRingHom ℝ`.  As requested this stays **off the gravity line**
and **off the Hankel-transform line** (only the concrete Majorana matrices of
`ChapterA3` and the discrete group `Ω` of `ChapterPinOmega` are used).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterLorentzRealRep

open BookProof.ChapterA3 BookProof.ChapterPinOmega

/-! ## The inverse inside `Ω` (integer model)

For `S ∈ Ω` one has `S² = ±1`, so the two-sided inverse is `S` itself when
`S² = 1` and `-S` otherwise; either way it stays inside `Ω`. -/

/-- Inverse of an element of `Ω` inside the integer matrix ring. -/
def cinv (S : Matrix (Fin 4) (Fin 4) ℤ) : Matrix (Fin 4) (Fin 4) ℤ :=
  if S * S = 1 then S else -S

/-- `cinv` really is a right inverse on `Ω`. -/
theorem cinv_correct : ∀ S ∈ Omega, S * cinv S = 1 := by decide

/-- `cinv` really is a left inverse on `Ω`. -/
theorem cinv_correct_left : ∀ S ∈ Omega, cinv S * S = 1 := by decide

/-! ## The three example bases (integer model) -/

/-- Basis of the `(1/2,1/2)` vector representation: `1, γ⁰γ¹, γ⁰γ², γ⁰γ³`.
(Recall `γ^μ = -i(iγ^μ)`, so `γ⁰γ^k = -(iγ⁰)(iγ^k)` is integral.) -/
def bHalf : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => 1
  | ⟨k + 1, h⟩ => -(mgammaZ 0 * mgammaZ ⟨k + 1, h⟩)

/-- Basis of the `(1,0)` representation: `iγ¹, iγ², iγ³, γ¹γ⁵, γ²γ⁵, γ³γ⁵`. -/
def b10 : Fin 6 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => mgammaZ 1
  | 1 => mgammaZ 2
  | 2 => mgammaZ 3
  | 3 => -(mgammaZ 1 * mgamma5Z)
  | 4 => -(mgammaZ 2 * mgamma5Z)
  | 5 => -(mgammaZ 3 * mgamma5Z)

/-- Basis of the pseudo-`(1/2,1/2)` representation: `iγ⁵, iγ⁵γ¹γ⁰, iγ⁵γ²γ⁰, iγ⁵γ³γ⁰`. -/
def bPs : Fin 4 → Matrix (Fin 4) (Fin 4) ℤ
  | 0 => mgamma5Z
  | ⟨k + 1, h⟩ => mgamma5Z * (-(mgammaZ ⟨k + 1, h⟩ * mgammaZ 0))

/-- Signed basis (`{±bᵢ}`) of the `(1/2,1/2)` representation. -/
def SBHalf : Finset (Matrix (Fin 4) (Fin 4) ℤ) :=
  (Finset.univ.image bHalf) ∪ (Finset.univ.image fun i => -bHalf i)

/-- Signed basis of the `(1,0)` representation. -/
def SB10 : Finset (Matrix (Fin 4) (Fin 4) ℤ) :=
  (Finset.univ.image b10) ∪ (Finset.univ.image fun i => -b10 i)

/-- Signed basis of the pseudo-`(1/2,1/2)` representation. -/
def SBPs : Finset (Matrix (Fin 4) (Fin 4) ℤ) :=
  (Finset.univ.image bPs) ∪ (Finset.univ.image fun i => -bPs i)

/-! ## Conjugation invariance (signed-permutation form), over `ℤ`

For every `S ∈ Ω` and every basis matrix `A`, the conjugate `S A S⁻¹` is again
`±` a basis matrix.  This is the representation-theoretic heart of Lemma 52 for
the discrete group `Ω`. -/

/-- **`(1/2,1/2)` invariance.** -/
theorem conj_inv_half : ∀ S ∈ Omega, ∀ i, S * bHalf i * cinv S ∈ SBHalf := by decide

/-- **`(1,0)` invariance.** -/
theorem conj_inv_10 : ∀ S ∈ Omega, ∀ i, S * b10 i * cinv S ∈ SB10 := by decide

/-- **pseudo-`(1/2,1/2)` invariance.** -/
theorem conj_inv_ps : ∀ S ∈ Omega, ∀ i, S * bPs i * cinv S ∈ SBPs := by decide

/-! ## Cardinalities (the number of basis matrices) -/

theorem card_half : (Finset.univ.image bHalf).card = 4 := by decide
theorem card_10 : (Finset.univ.image b10).card = 6 := by decide
theorem card_ps : (Finset.univ.image bPs).card = 4 := by decide

/-! ## Frobenius Gram matrices, over `ℤ` (all equal to `4·I`) -/

theorem gram_half : ∀ i j : Fin 4, ((bHalf i)ᵀ * bHalf j).trace = if i = j then 4 else 0 := by
  decide

theorem gram_10 : ∀ i j : Fin 6, ((b10 i)ᵀ * b10 j).trace = if i = j then 4 else 0 := by
  decide

theorem gram_ps : ∀ i j : Fin 4, ((bPs i)ᵀ * bPs j).trace = if i = j then 4 else 0 := by
  decide

/-! ## Real model: cast the bases into `ℝ` -/

/-- Cast an integer matrix to a real matrix. -/
noncomputable def castR : Matrix (Fin 4) (Fin 4) ℤ → Matrix (Fin 4) (Fin 4) ℝ :=
  (Int.castRingHom ℝ).mapMatrix

/-- `(1/2,1/2)` basis over `ℝ`. -/
noncomputable def bHalfR (i : Fin 4) : Matrix (Fin 4) (Fin 4) ℝ := castR (bHalf i)

/-- `(1,0)` basis over `ℝ`. -/
noncomputable def b10R (i : Fin 6) : Matrix (Fin 4) (Fin 4) ℝ := castR (b10 i)

/-- pseudo-`(1/2,1/2)` basis over `ℝ`. -/
noncomputable def bPsR (i : Fin 4) : Matrix (Fin 4) (Fin 4) ℝ := castR (bPs i)

/-- `castR` is multiplicative. -/
theorem castR_mul (A B : Matrix (Fin 4) (Fin 4) ℤ) : castR (A * B) = castR A * castR B :=
  map_mul ((Int.castRingHom ℝ).mapMatrix) A B

/-- `castR` respects transpose. -/
theorem castR_transpose (A : Matrix (Fin 4) (Fin 4) ℤ) : castR (Aᵀ) = (castR A)ᵀ := by
  ext i j; simp [castR, RingHom.mapMatrix_apply, Matrix.transpose_apply, Matrix.map_apply]

/-- `castR` respects trace. -/
theorem castR_trace (A : Matrix (Fin 4) (Fin 4) ℤ) : (castR A).trace = ((A.trace : ℤ) : ℝ) := by
  simp [castR, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply, Matrix.map_apply]

/-! ## Real Frobenius Gram matrices (cast of the integer ones) -/

theorem gram_halfR :
    ∀ i j : Fin 4, ((bHalfR i)ᵀ * bHalfR j).trace = if i = j then (4 : ℝ) else 0 := by
  intro i j;    rw [ show bHalfR i = castR ( bHalf i ) from rfl, show bHalfR j = castR ( bHalf j )
      from rfl ] ;    rw [ ← castR_transpose, ← castR_mul, castR_trace ] ; norm_num [ gram_half ] ;

theorem gram_10R : ∀ i j : Fin 6, ((b10R i)ᵀ * b10R j).trace = if i = j then (4 : ℝ) else 0 := by
  intro i j;    rw [ b10R, b10R, ← castR_transpose, ← castR_mul, castR_trace, gram_10 ] ; split_ifs
      <;> norm_num;

theorem gram_psR : ∀ i j : Fin 4, ((bPsR i)ᵀ * bPsR j).trace = if i = j then (4 : ℝ) else 0 := by
  intros i j;    rw [ show bPsR i = castR ( bPs i ) from rfl, show bPsR j = castR ( bPs j ) from
      rfl, ← castR_transpose, ← castR_mul, castR_trace ] ;
  split_ifs <;> simp_all [ gram_ps ]

/-! ## Linear independence from Frobenius orthogonality -/

/-
**Orthogonality ⇒ linear independence.**  A finite family of real `4×4`
matrices whose Frobenius Gram matrix is `4·I` (in particular, an orthogonal
family of nonzero matrices) is linearly independent.
-/
theorem linIndep_of_gram {n : ℕ} (v : Fin n → Matrix (Fin 4) (Fin 4) ℝ)
    (h : ∀ i j, ((v i)ᵀ * v j).trace = if i = j then (4 : ℝ) else 0) :
    LinearIndependent ℝ v := by
  rw [Fintype.linearIndependent_iff]
  intro g hg i
  have h_trace : ((∑ j, g j • v j)ᵀ * v i).trace = ∑ j, g j * ((v j)ᵀ * v i).trace := by
    simp [Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Matrix.trace_smul]
  simp_all

/-- The `(1/2,1/2)` basis is linearly independent (dimension `4`). -/
theorem bHalfR_linearIndependent : LinearIndependent ℝ bHalfR :=
  linIndep_of_gram bHalfR gram_halfR

/-- The `(1,0)` basis is linearly independent (dimension `6`). -/
theorem b10R_linearIndependent : LinearIndependent ℝ b10R :=
  linIndep_of_gram b10R gram_10R

/-- The pseudo-`(1/2,1/2)` basis is linearly independent (dimension `4`). -/
theorem bPsR_linearIndependent : LinearIndependent ℝ bPsR :=
  linIndep_of_gram bPsR gram_psR

/-! ## The three representation spaces (`ℝ`-submodules) -/

/-- The `(1/2,1/2)` vector representation space. -/
noncomputable def WHalf : Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) :=
  Submodule.span ℝ (Set.range bHalfR)

/-- The `(1,0)` representation space. -/
noncomputable def W10 : Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) := Submodule.span ℝ (Set.range b10R)

/-- The pseudo-`(1/2,1/2)` representation space. -/
noncomputable def WPs : Submodule ℝ (Matrix (Fin 4) (Fin 4) ℝ) := Submodule.span ℝ (Set.range bPsR)

/-- The conjugation linear map `A ↦ S A T` on real matrices. -/
noncomputable def conjL (S T : Matrix (Fin 4) (Fin 4) ℝ) :
    Matrix (Fin 4) (Fin 4) ℝ →ₗ[ℝ] Matrix (Fin 4) (Fin 4) ℝ :=
  (LinearMap.mulLeft ℝ S).comp (LinearMap.mulRight ℝ T)

theorem conjL_apply (S T A : Matrix (Fin 4) (Fin 4) ℝ) : conjL S T A = S * A * T := by
  simp [conjL, mul_assoc]

/-! ### Every element of the signed bases casts into the corresponding span -/

theorem castR_mem_WHalf : ∀ M ∈ SBHalf, castR M ∈ WHalf :=
  by
  intro M hM
  unfold SBHalf at hM
  simp only [Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM;
  rcases hM with ( ⟨ i, rfl ⟩ | ⟨ i, rfl ⟩ ) <;> [ refine Submodule.subset_span ⟨ i, rfl ⟩ ; refine
      Submodule.neg_mem ?_ ( Submodule.subset_span ⟨ i, rfl ⟩ ) ];
  convert Submodule.neg_mem _ ( Submodule.subset_span <| Set.mem_range_self i ) using 1;
  ext; simp [castR, bHalfR]

theorem castR_mem_W10 : ∀ M ∈ SB10, castR M ∈ W10 := by
  -- By definition of `SB10`, every element is either in the image of `b10` or the image of `-b10`.
  intro M hM
  simp only [SB10, Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM;
  obtain ⟨i, rfl⟩ | ⟨i, rfl⟩ := hM <;> simp only [W10]
  · exact Submodule.subset_span ⟨i, rfl⟩
  · rw [show castR (-b10 i) = -castR (b10 i) by ext; simp [castR]]
    exact Submodule.neg_mem _ <| Submodule.subset_span <| Set.mem_range_self _

theorem castR_mem_WPs : ∀ M ∈ SBPs, castR M ∈ WPs := by
  intro M hM
  unfold SBPs at hM
  simp only [Finset.mem_union, Finset.mem_image, Finset.mem_univ, true_and] at hM
  rcases hM with ⟨i, rfl⟩ | ⟨i, rfl⟩;
  · exact Submodule.subset_span ⟨ i, rfl ⟩;
  · convert Submodule.neg_mem _ ( Submodule.subset_span <| Set.mem_range_self i ) using 1;
    ext; simp [castR, bPsR]

/-! ### `Submodule` invariance under conjugation by `Ω` -/

/-
**`(1/2,1/2)` `Submodule` invariance.**  For `S ∈ Ω`, conjugation by `S`
maps the vector representation space into itself.
-/
theorem WHalf_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WHalf.map (conjL (castR S) (castR (cinv S))) ≤ WHalf := by
  apply Submodule.map_le_iff_le_comap.mpr;
  refine Submodule.span_le.mpr ?_;
  rintro _ ⟨ i, rfl ⟩;
  simp only [Submodule.comap_coe, bHalfR, Set.mem_preimage, conjL_apply, SetLike.mem_coe];
  rw [ ← castR_mul, ← castR_mul ];
  exact castR_mem_WHalf _ ( conj_inv_half S hS i )

/-
**`(1,0)` `Submodule` invariance.**
-/
theorem W10_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    W10.map (conjL (castR S) (castR (cinv S))) ≤ W10 := by
  apply Submodule.map_le_iff_le_comap.mpr
  refine Submodule.span_le.mpr ?_
  rintro _ ⟨i, rfl⟩
  simp only [b10R, conjL_apply, Submodule.mem_comap, SetLike.mem_coe]
  convert castR_mem_W10 _ (conj_inv_10 S hS i) using 1
  simp [castR_mul]

/-
**pseudo-`(1/2,1/2)` `Submodule` invariance.**
-/
theorem WPs_invariant (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega) :
    WPs.map (conjL (castR S) (castR (cinv S))) ≤ WPs := by
  apply Submodule.map_le_iff_le_comap.mpr
  refine Submodule.span_le.mpr ?_
  rintro _ ⟨i, rfl⟩
  simp only [bPsR, conjL_apply, Submodule.mem_comap, SetLike.mem_coe]
  convert castR_mem_WPs _ (conj_inv_ps S hS i) using 1
  simp [castR_mul]

/-- Elementwise form of `(1/2,1/2)` invariance: `A ∈ WHalf ⇒ S A S⁻¹ ∈ WHalf`. -/
theorem WHalf_invariant_apply (S : Matrix (Fin 4) (Fin 4) ℤ) (hS : S ∈ Omega)
    (A : Matrix (Fin 4) (Fin 4) ℝ) (hA : A ∈ WHalf) :
    castR S * A * castR (cinv S) ∈ WHalf := by
  have := WHalf_invariant S hS (Submodule.mem_map_of_mem hA)
  rwa [conjL_apply] at this

end BookProof.ChapterLorentzRealRep
