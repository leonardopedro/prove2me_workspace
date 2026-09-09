import Mathlib
import BookProof.ChapterA3

/-!
# Chapter A, §A.5 — the algebraic core of the Majorana–Fourier boost (Prop 73)

`book.tex` (§A.5, "Application to the momentum of Majorana spinor fields",
Proposition 73) proves that the **Majorana–Fourier transform**
`𝓕_M = S ∘ 𝓕_P^Θ` is unitary by reducing to the statement that the explicit
`2×2` block "boost mixing" matrix

```
S = [ c      -s·A ]
    [ s·A     c   ]
```

is **orthogonal / unitary**, where

* `c = √((E+m)/(2E))`, `s = √((E-m)/(2E))` are the boost half-angle coefficients
  (`E = √(q²+m²)` the relativistic energy, `q = |p⃗|` the momentum modulus,
  `m ≥ 0` the mass), and
* `A = (n̂·γ⃗) γ⁰` is built from the Dirac spatial slash of the unit momentum
  direction `n̂` (`Σ nᵢ² = 1`).

This file formalizes exactly that algebraic core, reusing the concrete `4×4`
Dirac model `BookProof.ChapterA3.dgamma`:

* the real half-angle identities `c² + s² = 1`, `c² − s² = m/E`, `2cs = q/E`;
* `A` is a **Hermitian involution** (`Aᴴ = A`, `A² = 1`), hence unitary;
* the abstract block lemma: for any Hermitian involution `A` and reals `c,s`
  with `c² + s² = 1`, the block matrix `S` is unitary (`Sᴴ S = 1`);
* the headline `majoranaFourier_boostBlock_unitary`: the concrete boost mixing
  matrix of Proposition 73 is unitary.

The surrounding analytic content (the integral operators `𝓕_P`, `𝓕_M` and their
unitarity as operators on `L²`) is left as prose; here we discharge the finite
linear-algebra identity on which the book's proof rests.

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterMajoranaFourier

open BookProof.ChapterA3

/-! ## The boost half-angle coefficients -/

/-- Relativistic energy `E = √(q² + m²)`. -/
noncomputable def Ep (m q : ℝ) : ℝ := Real.sqrt (q ^ 2 + m ^ 2)

/-- Boost half-angle cosine-type coefficient `c = √((E+m)/(2E))`. -/
noncomputable def boostC (m q : ℝ) : ℝ := Real.sqrt ((Ep m q + m) / (2 * Ep m q))

/-- Boost half-angle sine-type coefficient `s = √((E−m)/(2E))`. -/
noncomputable def boostS (m q : ℝ) : ℝ := Real.sqrt ((Ep m q - m) / (2 * Ep m q))

lemma Ep_pos (m q : ℝ) (hq : 0 < q) : 0 < Ep m q := by
  exact Real.sqrt_pos.mpr ( by positivity )

lemma Ep_ge (m q : ℝ) (_hm : 0 ≤ m) : m ≤ Ep m q := by
  exact Real.le_sqrt_of_sq_le ( by nlinarith )

lemma boostC_nonneg (m q : ℝ) : 0 ≤ boostC m q := Real.sqrt_nonneg _

lemma boostS_nonneg (m q : ℝ) : 0 ≤ boostS m q := Real.sqrt_nonneg _

/-
`c² + s² = 1`: the boost mixing coefficients lie on the unit circle.
-/
lemma boost_sq_add (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q) :
    boostC m q ^ 2 + boostS m q ^ 2 = 1 := by
      rw [ boostC, boostS, Real.sq_sqrt, Real.sq_sqrt ];
      · rw [ ← add_div, div_eq_iff ] <;> ring ; norm_num [ Ep, hm, hq ];
        positivity;
      · exact div_nonneg ( sub_nonneg.2 <| Real.le_sqrt_of_sq_le <|
          by nlinarith ) <| mul_nonneg zero_le_two <| Real.sqrt_nonneg _;
      · exact div_nonneg ( add_nonneg ( Real.sqrt_nonneg _ ) hm ) ( mul_nonneg zero_le_two (
          Real.sqrt_nonneg _ ) )

/-
`c² − s² = m/E`.
-/
lemma boost_sq_sub (m q : ℝ) (hm : 0 ≤ m) (_hq : 0 < q) :
    boostC m q ^ 2 - boostS m q ^ 2 = m / Ep m q := by
      convert congr_arg₂ ( · - · ) ( Real.sq_sqrt <| show 0 ≤ ( Ep m q + m ) / ( 2 * Ep m q ) from
                                 div_nonneg ( add_nonneg ( Real.sqrt_nonneg _ ) hm ) ( mul_nonneg
                                     zero_le_two ( Real.sqrt_nonneg _ ) ) ) ( Real.sq_sqrt <| show 0
                                         ≤ ( Ep m q - m ) / ( 2 * Ep m q ) from div_nonneg (
                                             sub_nonneg.mpr <| Real.le_sqrt_of_sq_le <|
                                                 by nlinarith ) ( mul_nonneg zero_le_two (
                                                     Real.sqrt_nonneg _ ) ) ) using 1;
      ring

/-
`2cs = q/E`.
-/
lemma boost_two_mul (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q) :
    2 * boostC m q * boostS m q = q / Ep m q := by
      unfold boostC boostS Ep; ring_nf; norm_num [ hq.le ] ;
      rw [ ← Real.sqrt_mul ( by positivity ) ] ; ring;
      field_simp;
      rw [ Real.sq_sqrt ( by positivity ), Real.sqrt_div' ] <;> ring <;> norm_num [ hq.le, hm ];
      · rw [ show m ^ 2 * 4 + q ^ 2 * 4 = ( m ^ 2 + q ^ 2 ) * 4 by ring, Real.sqrt_mul (
                                                                   by positivity ) ] ; ring;
        rw [ mul_assoc, mul_inv_cancel₀ ( by positivity ), mul_one ];
      · positivity

/-! ## Hermiticity of the Dirac matrices in the Majorana model -/

/-- Transpose of the integer Majorana matrices: `iγ⁰` is antisymmetric, the three
spatial ones are symmetric. -/
lemma mgammaZ_transpose (μ : Fin 4) :
    (mgammaZ μ)ᵀ = if μ = 0 then -mgammaZ μ else mgammaZ μ := by
  revert μ; decide

/-- Conjugate-transpose of the Majorana matrices: `iγ⁰` is antisymmetric, the
three spatial ones symmetric (and all are real). -/
lemma mgamma_conjTranspose (μ : Fin 4) :
    (mgamma μ)ᴴ = if μ = 0 then -mgamma μ else mgamma μ := by
  have hconj : (mgamma μ)ᴴ = (Int.castRingHom ℂ).mapMatrix ((mgammaZ μ)ᵀ) := by
    ext i j
    simp [mgamma, RingHom.mapMatrix_apply, Matrix.map_apply, Matrix.conjTranspose_apply,
      Matrix.transpose_apply]
  rw [hconj, mgammaZ_transpose]
  by_cases h : μ = 0
  · simp [h, mgamma, map_neg]
  · simp [h, mgamma]

/-- `γ⁰` is Hermitian and the spatial `γⁱ` are anti-Hermitian:
`(γ^μ)ᴴ = γ⁰` for `μ = 0`, `= −γ^μ` otherwise. -/
lemma dgamma_conjTranspose (μ : Fin 4) :
    (dgamma μ)ᴴ = if μ = 0 then dgamma μ else -dgamma μ := by
  rw [dgamma, Matrix.conjTranspose_smul, mgamma_conjTranspose]
  have hstar : star (-Complex.I) = Complex.I := by simp
  by_cases h : μ = 0
  · simp only [h, if_pos]; rw [hstar]; simp 
  · simp only [h]; rw [hstar]; simp 

/-
`(γ⁰)² = 1`.
-/
lemma gamma0_sq : dgamma 0 * dgamma 0 = 1 := by
  unfold dgamma BookProof.ChapterA3.mgamma;
  unfold mgammaZ;    ext i j; fin_cases i <;> fin_cases j <;> norm_num [ Complex.ext_iff,
      Matrix.mul_apply ] ;
  all_goals norm_cast;

/-
`γ⁰` anticommutes with each spatial `γⁱ` (`i = 0,1,2 ↦ γ^{i+1}`).
-/
lemma gamma0_spatial_anticomm (i : Fin 3) :
    dgamma 0 * dgamma i.succ = -(dgamma i.succ * dgamma 0) := by
      have := BookProof.ChapterA3.dgamma_clifford 0 ( Fin.succ i );
      simp_all only [Fin.isValue, minkowski, minkowskiZ, ↓reduceIte, Int.cast_ite, Int.cast_one,
          Int.cast_zero, mul_ite, mul_one, mul_zero, ite_smul, zero_smul];
      exact eq_neg_of_add_eq_zero_left ( this.trans ( by fin_cases i <;> rfl ) )

/-! ## The direction slash `A = (n̂·γ⃗) γ⁰` -/

/-- Spatial Dirac slash of a real 3-vector `n`, `n̸ = Σ nᵢ γ^{i+1}`. -/
noncomputable def nslash (n : Fin 3 → ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  ∑ i : Fin 3, (n i : ℂ) • dgamma i.succ

/-- The Prop-73 direction matrix `A = n̸ · γ⁰`. -/
noncomputable def Aop (n : Fin 3 → ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  nslash n * dgamma 0

/-
The spatial slash is anti-Hermitian: `n̸ᴴ = −n̸`.
-/
lemma nslash_conjTranspose (n : Fin 3 → ℝ) : (nslash n)ᴴ = -nslash n := by
  unfold nslash; simp only [Complex.coe_smul, conjTranspose_sum, conjTranspose_smul, star_trivial] ;
  rw [ ← Finset.sum_neg_distrib ] ; congr ; ext i ; rw [ dgamma_conjTranspose ] ; aesop;

/-
`γ⁰` anticommutes with the whole spatial slash: `γ⁰ n̸ = −n̸ γ⁰`.
-/
lemma gamma0_nslash_anticomm (n : Fin 3 → ℝ) :
    dgamma 0 * nslash n = -(nslash n * dgamma 0) := by
      unfold nslash; simp only [Fin.isValue, Complex.coe_smul, Finset.mul_sum _ _ _,
          Algebra.mul_smul_comm, Finset.sum_mul, Algebra.smul_mul_assoc] ;
      rw [ ← Finset.sum_neg_distrib ] ;        congr ; ext x ; rw [ gamma0_spatial_anticomm ] ; simp
          ;

/-
Each spatial `γⁱ` squares to `−1`.
-/
lemma dgamma_spatial_sq (i : Fin 3) : dgamma i.succ * dgamma i.succ = -1 := by
  fin_cases i <;> simp only [Fin.zero_eta, Fin.isValue, Fin.succ_zero_eq_one, Fin.mk_one,
      Fin.succ_one_eq_two, Fin.reduceFinMk, Fin.reduceSucc] ;
  · unfold dgamma;
    unfold mgamma;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Complex.ext_iff ];
    all_goals norm_cast;
  · unfold dgamma; simp only [Fin.isValue, neg_smul, mul_neg, Algebra.mul_smul_comm, neg_mul,
      Algebra.smul_mul_assoc, smul_neg, neg_neg]  ;
    unfold mgamma; simp only [mgammaZ, RingHom.mapMatrix_apply, Int.coe_castRingHom] ;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ ];
  · unfold dgamma; simp only [Fin.isValue, neg_smul, mul_neg, Algebra.mul_smul_comm, neg_mul,
      Algebra.smul_mul_assoc, smul_neg, neg_neg]  ;
    unfold mgamma; simp only [mgammaZ, Int.reduceNeg, RingHom.mapMatrix_apply, Int.coe_castRingHom]
        ;
    ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ ]

/-
Distinct spatial `γⁱ`, `γʲ` anticommute.
-/
lemma dgamma_spatial_anticomm (i j : Fin 3) (h : i ≠ j) :
    dgamma i.succ * dgamma j.succ = -(dgamma j.succ * dgamma i.succ) := by
      have := BookProof.ChapterA3.dgamma_clifford i.succ j.succ;
      simp_all only [ne_eq, minkowski, minkowskiZ, Fin.succ_inj, ↓reduceIte, Int.cast_zero,
          mul_zero, zero_smul];
      exact eq_neg_of_add_eq_zero_left this

/-
For a **unit** direction, the slash squares to `−1`: `n̸² = −1`.
-/
lemma nslash_sq (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    nslash n * nslash n = -1 := by
      simp only [nslash];
      simp only [Fin.sum_univ_three, Fin.isValue, Complex.coe_smul, Fin.succ_zero_eq_one,
          Fin.succ_one_eq_two, Fin.reduceSucc, Matrix.mul_add, Algebra.mul_smul_comm,
              Matrix.add_mul, Algebra.smul_mul_assoc, smul_add] at hn ⊢;
      -- Apply the known identities for the squares and products of the Dirac matrices.
      have h_identities : dgamma 1 * dgamma 1 = -1 ∧ dgamma 2 * dgamma 2 = -1 ∧ dgamma 3 * dgamma 3
          = -1 ∧ dgamma 1 * dgamma 2 = -(dgamma 2 * dgamma 1) ∧ dgamma 1 * dgamma 3 = -(dgamma 3 *
              dgamma 1) ∧ dgamma 2 * dgamma 3 = -(dgamma 3 * dgamma 2) := by
        exact ⟨ dgamma_spatial_sq 0, dgamma_spatial_sq 1, dgamma_spatial_sq 2,
            dgamma_spatial_anticomm 0 1 ( by decide ), dgamma_spatial_anticomm 0 2 (
                                             by decide ), dgamma_spatial_anticomm 1 2 (
                                                 by decide ) ⟩
      generalize_proofs at *; (
      simp_all only [Fin.isValue, smul_neg, ← smul_assoc, smul_eq_mul] ; ring!;
      convert congr_arg ( fun x : ℝ => x • ( -1 : Matrix ( Fin 4 ) ( Fin 4 ) ℂ ) ) hn using 1 ;
          focus (norm_num ; ring!);
      · module;
      · norm_num [ Algebra.smul_def ])

/-
`A = n̸ γ⁰` is Hermitian.
-/
lemma Aop_conjTranspose (n : Fin 3 → ℝ) : (Aop n)ᴴ = Aop n := by
  unfold Aop; simp only [Fin.isValue, conjTranspose_mul] ;
  rw [ nslash_conjTranspose, dgamma_conjTranspose ] ; norm_num;
  rw [ gamma0_nslash_anticomm, neg_neg ]

/-
For a unit direction, `A = n̸ γ⁰` is an involution: `A² = 1`.
-/
lemma Aop_sq (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    Aop n * Aop n = 1 := by
      convert congr_arg ( fun x : Matrix ( Fin 4 ) ( Fin 4 ) ℂ => ( nslash n ) * x * dgamma 0 ) (
          gamma0_nslash_anticomm n ) using 1;
      · simp only [Aop, mul_assoc];
      · simp [ ← mul_assoc, nslash_sq n hn, gamma0_sq ]

/-! ## The abstract boost block and its unitarity -/

/-- The `2×2` block boost mixing matrix `S = [[c, −s·A],[s·A, c]]`. -/
noncomputable def boostBlock (c s : ℝ) (A : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℂ :=
  Matrix.fromBlocks ((c : ℂ) • 1) ((-(s : ℂ)) • A) ((s : ℂ) • A) ((c : ℂ) • 1)

/-
**Abstract boost-block unitarity.** For any Hermitian involution `A`
(`Aᴴ = A`, `A² = 1`) and reals `c, s` with `c² + s² = 1`, the block matrix
`S = [[c, −s·A],[s·A, c]]` satisfies `Sᴴ S = 1`.
-/
theorem boostBlock_unitary {A : Matrix (Fin 4) (Fin 4) ℂ} (hA : Aᴴ = A)
    (hA2 : A * A = 1) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    (boostBlock c s A)ᴴ * boostBlock c s A = 1 := by
      unfold boostBlock;
      ext i j;
      rcases i with (i | i) <;> rcases j with (j | j)
        <;> norm_num [Matrix.mul_apply, Matrix.fromBlocks_multiply];
      · simp_all [ Matrix.one_apply, mul_assoc, mul_left_comm ];
        split_ifs <;> simp_all [ ← mul_assoc, ← Matrix.ext_iff ];
        · simp_all [ ← Finset.mul_sum _ _ _, mul_assoc, Matrix.mul_apply ];
          norm_cast ; linarith;
        · simp_all [ ← Finset.mul_sum _ _ _, mul_assoc, Matrix.mul_apply ];
      · simp_all only [one_apply, MonoidWithZeroHom.map_ite_one_zero, mul_ite, mul_one, mul_zero,
          ite_mul, zero_mul, Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte, reduceCtorEq];
        replace hA := congr_fun ( congr_fun hA i ) j ;          simp_all [
            Matrix.conjTranspose_apply, mul_comm ];
      · simp_all [ Matrix.one_apply, mul_comm, mul_left_comm ];
        rw [ ← Matrix.ext_iff ] at hA ; simp_all [ Complex.ext_iff ];
        constructor <;> ring;
      · simp_all [ Matrix.one_apply, mul_assoc, mul_left_comm, ← Finset.mul_sum _ _ _ ];
        simp_all [ ← mul_assoc, ← Matrix.ext_iff ];
        simp_all [ ← sq, Matrix.mul_apply ];
        split_ifs <;> simp_all [ sq, Complex.ext_iff ];
        simp_all [ Matrix.one_apply, Finset.sum_add_distrib ];
        linarith

/-- **Proposition 73 (algebraic core).** The concrete Majorana–Fourier boost
mixing matrix `S = [[c, −s·A],[s·A, c]]`, with `c, s` the boost half-angle
coefficients for mass `m ≥ 0` and momentum modulus `q > 0`, and
`A = (n̂·γ⃗) γ⁰` for a unit direction `n̂`, is unitary. -/
theorem majoranaFourier_boostBlock_unitary
    (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q)
    (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    (boostBlock (boostC m q) (boostS m q) (Aop n))ᴴ *
      boostBlock (boostC m q) (boostS m q) (Aop n) = 1 :=
  boostBlock_unitary (Aop_conjTranspose n) (Aop_sq n hn) (boost_sq_add m q hm hq)

end BookProof.ChapterMajoranaFourier
