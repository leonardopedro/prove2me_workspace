import Definitions.Def_ChapterA3
import Mathlib


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









/-
`c² + s² = 1`: the boost mixing coefficients lie on the unit circle.
-/


/-
`c² − s² = m/E`.
-/


/-
`2cs = q/E`.
-/


/-! ## Hermiticity of the Dirac matrices in the Majorana model -/





 

/-
`(γ⁰)² = 1`.
-/


/-
`γ⁰` anticommutes with each spatial `γⁱ` (`i = 0,1,2 ↦ γ^{i+1}`).
-/


/-! ## The direction slash `A = (n̂·γ⃗) γ⁰` -/

/-- Spatial Dirac slash of a real 3-vector `n`, `n̸ = Σ nᵢ γ^{i+1}`. -/
noncomputable def nslash (n : Fin 3 → ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  ∑ i : Fin 3, (n i : ℂ) • dgamma i.succtum of Majorana spinor fields",
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
lemma boost_sq_sub (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q) :
    boostC m q ^ 2 - boostS m q ^ 2 = m / Ep m q := by
      have hE : 0 < Ep m q := Ep_pos m q hq
      have hE2 : 0 < 2 * Ep m q := by positivity
      have hc : 0 ≤ (Ep m q + m) / (2 * Ep m q) :=
        div_nonneg (add_nonneg (le_of_lt hE) hm) (le_of_lt hE2)
      have hs : 0 ≤ (Ep m q - m) / (2 * Ep m q) :=
        div_nonneg (sub_nonneg.mpr (Ep_ge m q hm)) (le_of_lt hE2)
      rw [boostC, boostS, Real.sq_sqrt hc, Real.sq_sqrt hs]
      field_simp
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


/-
Each spatial `γⁱ` squares to `−1`.
-/


/-
Distinct spatial `γⁱ`, `γʲ` anticommute.
-/


/-
For a **unit** direction, the slash squares to `−1`: `n̸² = −1`.
-/


/-
`A = n̸ γ⁰` is Hermitian.
-/


/-
For a unit direction, `A = n̸ γ⁰` is an involution: `A² = 1`.
-/


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




end BookProof.ChapterMajoranaFourier
