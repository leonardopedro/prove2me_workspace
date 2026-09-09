import Mathlib

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Fourier-Majorana Transform", **Proposition 61** — the boost intertwiner `U'` is unitary

`book.tex` **Proposition 61** (line ~5712) states: given a unitary operator
`U : Pinorⱼ(ℝ³) → Pinorⱼ(𝕏)` with `U ∘ H² = E² ∘ U`, where `iH = γ⁰ (∂⃗·γ⃗) + iγ⁰ m`
is the Majorana/Dirac Hamiltonian (`H` self-adjoint) and `E(X) ≥ m ≥ 0`, the operator

  `U' ≡ (E + U H γ⁰ U†) / (√(E+m) √(2E))`

is unitary.

The book's proof is the algebraic identity `(U')† U' = 1` (and `U' (U')† = 1`), which
rests on three facts coming from the Majorana setup:

* the Clifford **anticommutation** `H γ⁰ + γ⁰ H = 2m` (from `iH = γ⁰(∂⃗·γ⃗) + iγ⁰ m`
  and `(γ⁰)² = 1`, `{γʲ, γ⁰} = 0`),
* the intertwining relation, i.e. `E² = U H² U†`,
* `E = √(E²)` (hence also the normaliser `√(2E(E+m))`) **commutes** with
  `A := U H γ⁰ U†`.

We formalize exactly this algebraic core in a general `ℝ`-star-algebra `𝒜`
(playing the role of the bounded operators on the pinor space): `U` unitary, `g = γ⁰`
a self-adjoint involution, `H` self-adjoint with the anticommutator
`H*g + g*H = (2m)•1`, `E` self-adjoint with `E*E = U*H²*U†`, `A := U*H*g*U†` commuting
with `E`, and a self-adjoint invertible normaliser `N` (`= √(2E(E+m))`) with
`N*N = 2•E² + (2m)•E` commuting with `E` and `A`.

We prove:

* `gsq_Hsq_comm` — `g*(H*H) = (H*H)*g` follows *purely* from the anticommutator
* `prop61_star_mul_self` — `(U')† U' = 1`
* `prop61_mul_star_self` — `U' (U')† = 1`
* `prop61_isUnit` — `U'` is a unit (two-sided inverse `(U')†`), the algebraic form of
  "`U'` is unitary".

As requested this stays **off the gravity line** and **off the Hankel-transform line**
(the surrounding integral operators `𝓕_M` and the Hankel-Majorana material of
Definitions 65–66 are not touched); only the Majorana/Dirac algebra is used.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterMajoranaProp61

variable {𝒜 : Type*} [Ring 𝒜] [StarRing 𝒜] [Algebra ℝ 𝒜] [StarModule ℝ 𝒜]

omit [StarRing 𝒜] [StarModule ℝ 𝒜] in
/-
**Clifford consequence.** If `H` and `g` satisfy the Majorana anticommutator
`H*g + g*H = (2m)•1`, then `H²` commutes with `g`. (This is the algebraic reason the
relativistic energy `E = √(H²)` is well defined and commutes with `γ⁰`-dressed
operators.)
-/
theorem gsq_Hsq_comm (H g : 𝒜) (m : ℝ) (hanti : H * g + g * H = (2 * m) • (1 : 𝒜)) :
    g * (H * H) = (H * H) * g := by
  simp_all [ mul_assoc, ← eq_sub_iff_add_eq' ]
  simp [ ← mul_assoc, hanti ]
  simp [ mul_sub, sub_mul, mul_assoc, hanti ]

/-- The `γ⁰`-dressed conjugated operator `A = U H γ⁰ U†` of Proposition 61. -/
def Aop (U H g : 𝒜) : 𝒜 := U * H * g * star U

/-- The boost intertwiner `U' = N⁻¹ (E + A)` of Proposition 61, with `N⁻¹`
represented by a given two-sided inverse `Ni` of the normaliser `N = √(2E(E+m))`. -/
def Uprime (U H g E Ni : 𝒜) : 𝒜 := Ni * (E + Aop U H g)

section
variable (U H g E N Ni : 𝒜) (m : ℝ)
  (hU₁ : star U * U = 1) (hU₂ : U * star U = 1)
  (hg_sa : star g = g) (hg2 : g * g = 1)
  (hH_sa : star H = H)
  (hanti : H * g + g * H = (2 * m) • (1 : 𝒜))
  (hE_sa : star E = E)
  (hE2 : E * E = U * (H * H) * star U)
  (hEA : E * Aop U H g = Aop U H g * E)
  (hN_sa : star N = N)
  (hN2 : N * N = (2 : ℝ) • (E * E) + (2 * m) • E)
  (hNi₁ : N * Ni = 1) (hNi₂ : Ni * N = 1)
  (hNE : N * E = E * N)
  (hNA : N * Aop U H g = Aop U H g * N)

include hU₁ hU₂ hg_sa hg2 hH_sa hanti hE_sa hE2 hEA hN_sa hN2 hNi₁ hNi₂ hNE hNA

set_option maxHeartbeats 2000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
omit [StarModule ℝ 𝒜] in
/-- **Proposition 61, `(U')† U' = 1`.** -/
theorem prop61_star_mul_self :
    star (Uprime U H g E Ni) * Uprime U H g E Ni = 1 := by
  -- By the properties of the adjoint and the given hypotheses, we can simplify the expression.
  have h_simp : (E + star (Aop U H g)) * (E + Aop U H g) = N * N := by
    simp_all only [Aop, star_mul, star_star, mul_add, add_mul]
    simp_all only [← eq_sub_iff_add_eq', ← mul_assoc]
    simp_all only [mul_assoc, mul_sub, Algebra.mul_smul_comm, mul_one, sub_mul,
      Algebra.smul_mul_assoc, one_mul, sub_sub_cancel]
    simp only [two_smul, add_assoc, add_sub_assoc, left_eq_add]
    abel1
  -- By the properties of the adjoint and the given hypotheses, we can simplify the expression
  -- further.
  have h_simp' : star Ni = Ni := by
    have h_star_Ni : star Ni * N = 1 := by
      rw [ ← star_one, ← hNi₁, star_mul, hN_sa ]
    apply_fun ( · * Ni ) at h_star_Ni; simp_all [ mul_assoc ]
  have h_simp'' : Ni * (E + star (Aop U H g)) = (E + star (Aop U H g)) * Ni := by
    have h_simp'' : Ni * E = E * Ni := by
      apply_fun (fun x => Ni * x) at hNE; simp_all [ mul_assoc ]
      grind
    have h_simp''' : Ni * star (Aop U H g) = star (Aop U H g) * Ni := by
      have h_simp''' : N * star (Aop U H g) = star (Aop U H g) * N := by
        apply_fun star at hNA; simp_all [ mul_assoc, star_mul ]
      apply_fun (fun x => Ni * x) at h_simp'''
      grind
    simp_all [ mul_add, add_mul ]
  convert congr_arg ( fun x => Ni * Ni * x ) h_simp using 1
  · simp [ Uprime, mul_assoc, h_simp' ]
    simp [ ← mul_assoc, hE_sa, h_simp'' ]
  · grind

set_option maxHeartbeats 2000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
omit [StarModule ℝ 𝒜] hNE hNA in
/-- **Proposition 61, `U' (U')† = 1`.** -/
theorem prop61_mul_star_self :
    Uprime U H g E Ni * star (Uprime U H g E Ni) = 1 := by
  -- Using the hypothesis `hNi₂ : Ni * N = 1`, we can simplify the expression.
  have h_comm : Ni * (E + Aop U H g) * (E + star (Aop U H g)) * Ni = Ni * N * N * Ni := by
    have h_comm : (E + Aop U H g) * (E + star (Aop U H g)) = 2 • (E * E) + (2 * m) • E := by
      simp only [mul_add, add_mul, hE2, two_smul]
      simp_all only [← mul_assoc, Aop, star_mul, star_star]
      simp_all only [← eq_sub_iff_add_eq', mul_assoc, mul_one]
      simp_all only [sub_mul, Algebra.smul_mul_assoc, one_mul, mul_assoc, mul_sub,
        Algebra.mul_smul_comm, mul_one]
      abel1
    simp only [mul_assoc, h_comm]
    simp only [nsmul_eq_mul, Nat.cast_ofNat, ← mul_assoc]
    simp only [two_mul, add_mul, mul_add, Algebra.mul_smul_comm, mul_assoc, Algebra.smul_mul_assoc,
        hN2, add_left_inj]
    rw [ two_smul ]
  unfold Uprime; simp_all only [mul_assoc, one_mul, star_mul, star_add]
  have h_star_Ni : star Ni * N = 1 := by
    rw [ ← star_inj ] ; simp [ * ]
  apply_fun ( · * Ni ) at h_star_Ni; simp_all [ mul_assoc ]

omit [StarModule ℝ 𝒜] in
/-- **Proposition 61 (headline).**  The boost intertwiner `U'` is unitary: it has the
two-sided inverse `(U')†`. -/
theorem prop61_isUnit : IsUnit (Uprime U H g E Ni) :=
  ⟨⟨Uprime U H g E Ni, star (Uprime U H g E Ni),
      prop61_mul_star_self U H g E N Ni m hU₁ hU₂ hg_sa hg2 hH_sa hanti hE_sa hE2 hEA
        hN_sa hN2 hNi₁ hNi₂,
      prop61_star_mul_self U H g E N Ni m hU₁ hU₂ hg_sa hg2 hH_sa hanti hE_sa hE2 hEA
        hN_sa hN2 hNi₁ hNi₂ hNE hNA⟩,
    rfl⟩

end

end BookProof.ChapterMajoranaProp61
