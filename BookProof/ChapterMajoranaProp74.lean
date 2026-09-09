import Mathlib
import BookProof.ChapterMajoranaFourier

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Fourier-Majorana Transform", **Proposition 74** — the inverse Majorana–Fourier
intertwining identities

`book.tex` **Proposition 74** (line ~6003) states that the inverse Majorana–Fourier
transform `𝓕_M⁻¹ = (𝓕_P^Θ)⁻¹ ∘ S⁻¹` intertwines the Dirac operator with a momentum
multiplier:

  `(γ⁰ γ⃗·∂⃗ + i γ⁰ m) 𝓕_M⁻¹{Ψ} = (𝓕_M⁻¹ ∘ R){Ψ}`,   `R{Ψ}(p⃗) = i γ⁰ E_p Ψ(p⃗)`,
  `∂ⱼ 𝓕_M⁻¹{Ψ} = (𝓕_M⁻¹ ∘ Rⱼ){Ψ}`,                     `Rⱼ{Ψ}(p⃗) = i γ⁰ pⱼ Ψ(p⃗)`.

Writing `𝓕_M⁻¹ = (𝓕_P^Θ)⁻¹ ∘ S⁻¹`, the book reduces both statements to purely
algebraic `2×2`-block identities over the Dirac matrices, on the two-component
`(+p⃗, −p⃗)` momentum splitting:

* `Q ∘ S⁻¹ = S⁻¹ ∘ R`, where
  `Q = [[i γ⁰ m, i p⃗·γ⃗], [−i p⃗·γ⃗, i γ⁰ m]]`,
  `S⁻¹ = [[c, s A], [−s A, c]]`,
  `R = diag(i γ⁰ E, i γ⁰ E)`,
  with `A = (n̂·γ⃗) γ⁰`, `c = √((E+m)/(2E))`, `s = √((E−m)/(2E))`, `p⃗ = |p⃗| n̂`;
* `Rⱼ ∘ S⁻¹ = S⁻¹ ∘ Rⱼ`, i.e. the diagonal block `Dⱼ = diag(i γ⁰ pⱼ, −i γ⁰ pⱼ)`
  commutes with `S⁻¹`.

This file formalizes exactly those two block identities, reusing the concrete `4×4`
Dirac model and the boost coefficients from `BookProof.ChapterMajoranaFourier`
(`dgamma`, `nslash`, `Aop`, `boostC`, `boostS`, `Ep` and the Clifford relations
`gamma0_sq`, `nslash_sq`, `gamma0_nslash_anticomm`).  Both identities are proved
first as **abstract** statements for any pair `g, ns` of `4×4` complex matrices
satisfying the Majorana relations `g² = 1`, `ns² = −1`, `g·ns = −ns·g`, and then
instantiated on the concrete Dirac model.

The surrounding analytic content (the integral transforms `𝓕_P`, `𝓕_M` and their
inverses) is left as prose; here we discharge the finite linear-algebra core on
which the book's proof rests.  This stays **off the gravity line** and **off the
Hankel-transform line**.

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterMajoranaProp74

open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

/-! ## The block operators of Proposition 74 -/

/-- The Dirac-operator momentum block `Q = [[i γ⁰ m, i p⃗·γ⃗], [−i p⃗·γ⃗, i γ⁰ m]]`,
with `g = γ⁰` and `ns = p⃗·γ⃗ / |p⃗|` scaled by the modulus `q = |p⃗|`. -/
noncomputable def Qmat (g ns : Matrix (Fin 4) (Fin 4) ℂ) (m q : ℝ) :
    Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℂ :=
  Matrix.fromBlocks (((m : ℂ) * Complex.I) • g) (((q : ℂ) * Complex.I) • ns)
    ((-((q : ℂ) * Complex.I)) • ns) (((m : ℂ) * Complex.I) • g)

/-- The inverse boost-mixing block `S⁻¹ = [[c, s A], [−s A, c]]`. -/
noncomputable def Sinv (A : Matrix (Fin 4) (Fin 4) ℂ) (c s : ℝ) :
    Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℂ :=
  Matrix.fromBlocks ((c : ℂ) • 1) ((s : ℂ) • A) ((-(s : ℂ)) • A) ((c : ℂ) • 1)

/-- The energy multiplier block `R = diag(i γ⁰ E, i γ⁰ E)`. -/
noncomputable def Rmat (g : Matrix (Fin 4) (Fin 4) ℂ) (E : ℝ) :
    Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℂ :=
  Matrix.fromBlocks (((E : ℂ) * Complex.I) • g) 0 0 (((E : ℂ) * Complex.I) • g)

/-- The momentum-component multiplier block `Dⱼ = diag(i γ⁰ pⱼ, −i γ⁰ pⱼ)`. -/
noncomputable def Dmat (g : Matrix (Fin 4) (Fin 4) ℂ) (pj : ℝ) :
    Matrix (Fin 4 ⊕ Fin 4) (Fin 4 ⊕ Fin 4) ℂ :=
  Matrix.fromBlocks (((pj : ℂ) * Complex.I) • g) 0 0 ((-((pj : ℂ) * Complex.I)) • g)

/-! ## Clifford consequences for `A = ns · g` -/

/-
`ns · A = −g` when `A = ns·g` and `ns² = −1`.
-/
theorem ns_mul_A {g ns : Matrix (Fin 4) (Fin 4) ℂ} (hns2 : ns * ns = -1) :
    ns * (ns * g) = -g := by
      rw [ ← Matrix.mul_assoc, hns2, neg_one_mul ]

/-
`g · A = −ns` when `A = ns·g`, `g·ns = −ns·g` and `g² = 1`.
-/
theorem g_mul_A {g ns : Matrix (Fin 4) (Fin 4) ℂ} (hg2 : g * g = 1)
    (hgns : g * ns = -(ns * g)) : g * (ns * g) = -ns := by
      rw [ ← mul_assoc, hgns, neg_mul, mul_assoc, hg2, mul_one ]

/-
`A · g = ns` when `A = ns·g` and `g² = 1`.
-/
theorem A_mul_g {g ns : Matrix (Fin 4) (Fin 4) ℂ} (hg2 : g * g = 1) :
    (ns * g) * g = ns := by
      rw [ mul_assoc, hg2, mul_one ]

/-! ## The abstract intertwining identities -/

/-
**Proposition 74, first identity (abstract).** For any `4×4` matrices `g, ns`
with `g² = 1`, `ns² = −1`, `g·ns = −ns·g`, and reals `c, s, m, q, E` with
`c² + s² = 1`, `m = (c²−s²)E`, `q = 2csE`, the Dirac-operator block `Q`
intertwines with the boost mixing `S⁻¹` and the energy multiplier `R`:
`Q · S⁻¹ = S⁻¹ · R`.
-/
theorem prop74_intertwine (g ns : Matrix (Fin 4) (Fin 4) ℂ)
    (hg2 : g * g = 1) (hns2 : ns * ns = -1) (hgns : g * ns = -(ns * g))
    (c s m q E : ℝ) (hcs : c ^ 2 + s ^ 2 = 1) (hm : m = (c ^ 2 - s ^ 2) * E)
    (hq : q = 2 * c * s * E) :
    Qmat g ns m q * Sinv (ns * g) c s = Sinv (ns * g) c s * Rmat g E := by
      unfold Qmat Sinv Rmat;
      simp only [neg_smul, Complex.coe_smul, fromBlocks_multiply, Algebra.mul_smul_comm, mul_one,
          mul_neg, Algebra.smul_mul_assoc, ← Matrix.mul_assoc, smul_neg, neg_mul, one_mul, mul_zero,
              add_zero, zero_add, fromBlocks_inj];
      simp_all only [mul_comm, mul_left_comm, Complex.ofReal_mul, Complex.ofReal_sub,
          Complex.ofReal_pow, Complex.ofReal_ofNat, neg_mul, one_mul, smul_neg, neg_neg, mul_assoc,
              mul_one];
      refine ⟨ ?_, ?_, ?_, ?_ ⟩ <;> ext <;> norm_num <;> ring;
      · rw [ show ( s : ℂ ) ^ 2 = 1 - c ^ 2 by norm_cast; linarith ] ; ring;
      · rw [ show ( s : ℂ ) ^ 3 = s * s ^ 2 by ring, show ( s : ℂ ) ^ 2 = 1 - c ^ 2
                                               by norm_cast; linarith ] ; ring;
      · rw [ show ( s : ℂ ) ^ 3 = s * s ^ 2 by ring, show ( s : ℂ ) ^ 2 = 1 - c ^ 2
                                               by norm_cast; linarith ] ; ring;
      · rw [ show ( s : ℂ ) ^ 2 = 1 - c ^ 2 by norm_cast; linarith ] ; ring

/-
**Proposition 74, second identity (abstract).** For any `4×4` matrices `g, ns`
with `g² = 1` and `g·ns = −ns·g`, the diagonal momentum-component block `Dⱼ`
commutes with the boost mixing `S⁻¹`: `Dⱼ · S⁻¹ = S⁻¹ · Dⱼ`.
-/
theorem prop74_Rj_comm (g ns : Matrix (Fin 4) (Fin 4) ℂ)
    (_hg2 : g * g = 1) (hgns : g * ns = -(ns * g)) (c s pj : ℝ) :
    Dmat g pj * Sinv (ns * g) c s = Sinv (ns * g) c s * Dmat g pj := by
      unfold Dmat Sinv;
      simp only [neg_smul, Complex.coe_smul, fromBlocks_multiply, Algebra.mul_smul_comm, mul_one,
          mul_neg, zero_mul, smul_zero, neg_zero, add_zero, Algebra.smul_mul_assoc, neg_mul,
              smul_neg, neg_neg, zero_add, one_mul, mul_zero, Matrix.mul_assoc, fromBlocks_inj,
                  neg_inj, and_self_left];
      simp only [← smul_assoc, Complex.real_smul, ← mul_assoc, hgns, neg_mul, smul_neg, neg_inj];
      exact ⟨ by ext; simp [ mul_assoc, mul_left_comm ], by ext; simp [ mul_assoc, mul_left_comm ],
                                                            by ext; simp [ mul_assoc, mul_left_comm
                                                                ] ⟩

/-! ## The concrete Dirac-model instantiations -/

/-
**Proposition 74, first identity (concrete Dirac model).** With `g = γ⁰`,
`ns = p⃗·γ⃗/|p⃗|`, `A = (n̂·γ⃗) γ⁰`, boost coefficients `c, s` for mass `m ≥ 0` and
momentum modulus `q > 0`, and energy `E = √(q²+m²)`, the Dirac-operator block `Q`
intertwines with `S⁻¹` and the energy multiplier `R`.
-/
theorem majoranaFourier_prop74 (m q : ℝ) (hm : 0 ≤ m) (hq : 0 < q)
    (n : Fin 3 → ℝ) (hn : ∑ i, (n i) ^ 2 = 1) :
    Qmat (dgamma 0) (nslash n) m q * Sinv (Aop n) (boostC m q) (boostS m q)
      = Sinv (Aop n) (boostC m q) (boostS m q) * Rmat (dgamma 0) (Ep m q) := by
        convert prop74_intertwine ( dgamma 0 ) ( nslash n ) gamma0_sq ( nslash_sq n hn ) (
            gamma0_nslash_anticomm n ) ( boostC m q ) ( boostS m q ) m q ( Ep m q ) ( boost_sq_add m
                q hm hq ) _ _ using 1;
        · rw [ boost_sq_sub m q hm hq, div_mul_cancel₀ _ ( ne_of_gt ( Ep_pos m q hq ) ) ];
        · rw [ BookProof.ChapterMajoranaFourier.boost_two_mul m q hm hq, div_mul_cancel₀ _ (
            ne_of_gt ( BookProof.ChapterMajoranaFourier.Ep_pos m q hq ) ) ]

/-
**Proposition 74, second identity (concrete Dirac model).** With `g = γ⁰` and
`A = (n̂·γ⃗) γ⁰`, the diagonal momentum-component block `Dⱼ` commutes with `S⁻¹`.
-/
theorem majoranaFourier_prop74_Rj (n : Fin 3 → ℝ) (c s pj : ℝ) :
    Dmat (dgamma 0) pj * Sinv (Aop n) c s = Sinv (Aop n) c s * Dmat (dgamma 0) pj := by
  exact prop74_Rj_comm (dgamma 0) (nslash n) gamma0_sq (gamma0_nslash_anticomm n) c s pj

end BookProof.ChapterMajoranaProp74
