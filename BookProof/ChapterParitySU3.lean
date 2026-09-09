import Mathlib
import BookProof.ChapterParity

/-!
# Chapter "On the physical parity transformation and antiparticles" — `SU(3)` has a
nontrivial `ℤ₂` outer automorphism (complex conjugation of the Gell-Mann generators)

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter states:

  *"The outer automorphism group of `SU(3)` or `U(1)_Y` is `Z₂`, while the outer
  automorphism group of `SU(2)_L` is the trivial group."*

and uses the associated automorphism to fix the parity signs of the gluon fields
`G_μ^a ↦ s^a G_μ^a(t,-x)` (with `s^{1,3,4,6,8} = -1`, `s^{2,5,7} = +1`).

The relevant automorphism is **entrywise complex conjugation** `X ↦ X̄` (which sends a
representation to its complex-conjugate representation).  `ChapterParitySU2` proved that for
`SU(2)` this conjugation is *inner* (realized by conjugation with the fixed involution
`σ₂`), so the outer automorphism group of `SU(2)_L` is trivial.  Here we treat the
complementary `SU(3)` side.

Building on `ChapterParity.gellMann` and the sign law
`ChapterParity.gellMann_conj : conj(λ^a) = ε^a λ^a`
(with `ε = (+,-,+,+,-,+,-,+)`), we show that complex conjugation is a genuine,
order-`2`, **nontrivial** automorphism of the `su(3)` Lie bracket:

* `gellMannConjSign_sq` — each eigenvalue is `±1`: `(ε^a)² = 1`;
* `gellMann_conj_involutive` — conjugation is an involution `X̄̄ = X` (order dividing `2`);
* `gellMann_bracket_conj` — **headline**: conjugation respects the Lie bracket,
  `conj([λ^a, λ^b]) = ε^a ε^b · [λ^a, λ^b]`, i.e. it is a Lie-algebra homomorphism; since
  `[λ^a, λ^b] = i f^{abc} λ^c` this simultaneously encodes the structure-constant sign law
  `ε^a ε^b f^{abc} = ε^c f^{abc}` (equivalently `s^a s^b s^c f^{abc} = f^{abc}`, the
  invariance of the cubic gauge vertex under the gluon parity signs `s = -ε`);
* `gellMann_conj_nontrivial` — conjugation is **not** the identity on the generators
  (it negates `λ²`), so — unlike the inner `SU(2)` case — the `SU(3)` conjugation is the
  nontrivial generator of the `ℤ₂` outer automorphism group.

The remaining physical modelling (the full Standard-Model gauge structure, the gluon
parity transformation) is left as prose.  The genuinely *outer* (non-inner) character of
the `SU(3)` conjugation is the standard representation-theoretic fact contrasted with the
`SU(2)` intertwiner of `ChapterParitySU2`; here we record the order-`2`, bracket-preserving,
nontrivial-on-generators content that witnesses it.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParitySU3

open BookProof.ChapterParity

/-- Each complex-conjugation eigenvalue of a Gell-Mann generator squares to `1`
(`ε^a ∈ {+1, -1}`), so entrywise conjugation is an involution on each generator. -/
theorem gellMannConjSign_sq (a : Fin 8) : gellMannConjSign a ^ 2 = 1 := by
  fin_cases a <;> simp [gellMannConjSign]

/-- Entrywise complex conjugation is an **involution** on the Gell-Mann generators:
`conj(conj(λ^a)) = λ^a`.  Hence the conjugation automorphism has order dividing `2`. -/
theorem gellMann_conj_involutive (a : Fin 8) :
    ((gellMann a).map (starRingEnd ℂ)).map (starRingEnd ℂ) = gellMann a := by
  ext i j; simp [Matrix.map_apply]

/-- **Complex conjugation is a Lie-algebra automorphism of `su(3)`.**  On the Gell-Mann
generators it respects the commutator bracket up to the product of the conjugation signs:

  `conj([λ^a, λ^b]) = ε^a ε^b · [λ^a, λ^b]`.

Since `[λ^a, λ^b] = i f^{abc} λ^c`, this is exactly the structure-constant sign law
`ε^a ε^b f^{abc} = ε^c f^{abc}`, equivalently `s^a s^b s^c f^{abc} = f^{abc}` for the gluon
parity signs `s = -ε`: the cubic gauge vertex is invariant under `G_μ^a ↦ s^a G_μ^a`. -/
theorem gellMann_bracket_conj (a b : Fin 8) :
    (gellMann a * gellMann b - gellMann b * gellMann a).map (starRingEnd ℂ)
      = (gellMannConjSign a * gellMannConjSign b) •
          (gellMann a * gellMann b - gellMann b * gellMann a) := by
  have hsub : ∀ (M N : Matrix (Fin 3) (Fin 3) ℂ),
      (M - N).map (starRingEnd ℂ) = M.map (starRingEnd ℂ) - N.map (starRingEnd ℂ) := by
    intro M N; ext i j; simp [Matrix.map_apply, Matrix.sub_apply]
  rw [hsub, Matrix.map_mul, Matrix.map_mul, gellMann_conj, gellMann_conj,
      smul_mul_smul_comm, smul_mul_smul_comm,
      mul_comm (gellMannConjSign b) (gellMannConjSign a), smul_sub]

/-- **The `SU(3)` conjugation is nontrivial on the generators.**  Entrywise conjugation is
*not* the identity: it negates `λ²` (`gellMann 1`).  Together with `gellMann_bracket_conj`
(bracket-preserving) and `gellMann_conj_involutive` (order `2`), this exhibits complex
conjugation as the nontrivial generator of the `ℤ₂` outer automorphism group of `SU(3)` —
in contrast with `SU(2)`, whose conjugation is inner (`ChapterParitySU2.su2_conj_inner`). -/
theorem gellMann_conj_nontrivial :
    ∃ a : Fin 8, (gellMann a).map (starRingEnd ℂ) ≠ gellMann a := by
  refine ⟨1, ?_⟩
  rw [gellMann_conj]
  intro hc
  have h2 := congrFun (congrFun hc 0) 1
  rw [Matrix.smul_apply] at h2
  simp only [gellMann, gellMannConjSign] at h2
  norm_num [Matrix.of_apply, Complex.ext_iff] at h2

end BookProof.ChapterParitySU3
