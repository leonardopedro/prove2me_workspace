import Mathlib
import BookProof.ChapterH1

/-!
# Chapter H2 — Hashimoto SIRK: Krylov compression (roadmap N13, §0 S7)

This file continues the Hashimoto–Nodera *Shift-invert Rational Krylov (SIRK)*
formalization (source `RiemannProof/Hashimoto.md`) begun in `ChapterH1.lean`.

## Deliverables (this file)

* **H2.1 — the Arnoldi/Krylov compression relation** (§4, eqs. 5, 7): with an
  orthonormal basis `v₁,…,vₘ` of the Krylov subspace and the nesting
  `X 𝒦_j ⊆ 𝒦_{j+1}`, the compression `Vₘᴴ X Vₘ = Hₘ` is upper-Hessenberg —
  `h_{i,j} = ⟪vᵢ, X vⱼ⟫ = 0` whenever `i > j+1` (`hessenberg_vanishing`,
  `compression_upper_hessenberg`).

The genuinely deep analytic convergence inputs (Crouzeix's inequality and the
Göckler–Grimm / Hashimoto RK error theorems, deliverables H2.3/H2.4) are
recorded in `BookProof/STATUS.md` as the `EXTERNAL`/`CrouzeixBound` design
target and are **not** asserted here — no `axiom`, ever.

Everything in this file is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open scoped BigOperators Matrix

namespace BookProof.ChapterH2

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-! ## H2.1 — the Arnoldi/Krylov compression is upper-Hessenberg -/

/-
**H2.1** (Hessenberg vanishing): let `v : Fin n → E` be an orthonormal
system, and let `X` be an operator whose action on `vⱼ` lands in the span of
`{v_l : l ≤ j+1}` (the Krylov nesting `X 𝒦_j ⊆ 𝒦_{j+1}`).  Then for `i > j+1`
the compression entry `⟪vᵢ, X vⱼ⟫` vanishes — the compression matrix is upper
Hessenberg.
-/
theorem hessenberg_vanishing {n : ℕ} (v : Fin n → E) (hv : Orthonormal ℂ v)
    (X : E →ₗ[ℂ] E) (j i : Fin n)
    (hnest : X (v j) ∈ Submodule.span ℂ {w : E | ∃ l : Fin n, (l : ℕ) ≤ (j : ℕ) + 1 ∧ w = v l})
    (hij : (j : ℕ) + 1 < (i : ℕ)) :
    inner (𝕜 := ℂ) (v i) (X (v j)) = 0 := by
  refine Submodule.span_induction ?_ ?_ ?_ ?_ hnest;
  · simp? +zetaDelta at *;
    intro x l hl hx; rw [ hx, hv.2 ( show i ≠ l from by rintro rfl; linarith ) ] ;
  · simp;
  · simp +contextual ;
  · simp +contextual 

/-- **H2.1** (compression is upper-Hessenberg): the compressed operator entries
`Hₘ_{i,j} := ⟪vᵢ, X vⱼ⟫` vanish below the first subdiagonal (`i > j+1`), given the
Krylov nesting hypothesis for every column `j`. -/
theorem compression_upper_hessenberg {n : ℕ} (v : Fin n → E) (hv : Orthonormal ℂ v)
    (X : E →ₗ[ℂ] E)
    (hnest : ∀ j : Fin n,
      X (v j) ∈ Submodule.span ℂ {w : E | ∃ l : Fin n, (l : ℕ) ≤ (j : ℕ) + 1 ∧ w = v l})
    (i j : Fin n) (hij : (j : ℕ) + 1 < (i : ℕ)) :
    inner (𝕜 := ℂ) (v i) (X (v j)) = 0 :=
  hessenberg_vanishing v hv X j i (hnest j) hij

/-! ## H2.2 — the SIRK compression `Vₘᴴ Xₘ Vₘ = Hₘ Kₘ⁻¹` (eq. 10) -/

/-
**H2.2** (SIRK compression, eq. 10): given the rational-Arnoldi invariance
relation `X V = V (H K⁻¹)` (assembled from H1.6 + H2.1 + the RK relation (9)) and
an orthonormal basis matrix `V` (`Vᴴ V = 1`), the compression of `X_m` onto the
rational Krylov subspace is `Vᴴ X V = H K⁻¹`.  One line from associativity and
`Vᴴ V = 1`.
-/
theorem sirk_compression {p m : ℕ} (V : Matrix (Fin p) (Fin m) ℂ)
    (X : Matrix (Fin p) (Fin p) ℂ) (H K : Matrix (Fin m) (Fin m) ℂ) [Invertible K]
    (hV : Vᴴ * V = 1)
    (hrel : X * V = V * (H * ⅟K)) :
    Vᴴ * X * V = H * ⅟K := by
  rw [ Matrix.mul_assoc, hrel, ← Matrix.mul_assoc, hV, Matrix.one_mul ]

/-! ## H2.3 — the SIRK convergence bound, conditional on `CrouzeixBound` -/

/-
**H2.3** (SIRK error bound (13)+(14), CONDITIONAL on Crouzeix's inequality).
The two hypotheses `hC1`, `hC2` are the two applications of the named *external*
Crouzeix bound `‖f(A)‖ ≤ C·‖f‖_{∞,W(A)}` (Crouzeix 2007, Prop. 2.3 / eq. 14);
they are named hypotheses with citation, **never axioms**.  `hrepr` is the
rational-Krylov identity `r(X_m)v = V r(H K⁻¹) Vᴴ v`.  Given these, the SIRK
approximation error obeys `‖φ_k(A)v − V ψ(HK⁻¹) Vᴴ v‖ ≤ 2C‖v‖·‖ψ−r‖_{∞,Σ}`
(here `T = ψ_{k,γ_m}(X_m)`, `SH = ψ_{k,γ_m}(HK⁻¹)`, `D = ‖ψ−r‖_{∞,Σ}`), by the
triangle inequality and the two Crouzeix applications.  The `e^{-hm}` refinement
and the `min` over `r` (Theorem 4.1, via Hashimoto–Nodera [10] Theorem 5) are the
remaining external analytic step recorded in the docstring.
-/
theorem sirk_error_bound_of_crouzeix
    {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E]
    [NormedAddCommGroup F] [NormedSpace ℂ F]
    (T rXm : E →L[ℂ] E) (SH rH : F →L[ℂ] F) (V : F →L[ℂ] E) (W : E →L[ℂ] F)
    (C D : ℝ) (hVnorm : ‖V‖ ≤ 1) (hWnorm : ‖W‖ ≤ 1)
    (hrepr : ∀ v : E, rXm v = V (rH (W v)))
    (hC1 : ‖T - rXm‖ ≤ C * D) (hC2 : ‖SH - rH‖ ≤ C * D)
    (v : E) :
    ‖T v - V (SH (W v))‖ ≤ 2 * C * D * ‖v‖ := by
  convert le_trans ( norm_add_le ( ( T - rXm ) v ) ( V ( ( rH - SH ) ( W v ) ) ) ) _ using 1;
  · simp [ hrepr, sub_add ];
  · refine le_trans ( add_le_add ( ContinuousLinearMap.le_opNorm _ _ ) (
      ContinuousLinearMap.le_opNorm _ _ ) ) ?_;
    refine le_trans ( add_le_add ( mul_le_mul_of_nonneg_right hC1 ( norm_nonneg _ ) )
      ( mul_le_mul hVnorm ( ContinuousLinearMap.le_opNorm _ _ ) ( by positivity )
        ( by positivity ) ) ) ?_;
    rw [ norm_sub_rev ];
    nlinarith [ norm_nonneg v, norm_nonneg ( W v ), norm_nonneg ( SH - rH ),
        mul_le_mul_of_nonneg_left hWnorm ( norm_nonneg v ), mul_le_mul_of_nonneg_left hVnorm (
            norm_nonneg v ), ContinuousLinearMap.le_opNorm W v ]

/-! ## H2.4 — the SIRK-vs-SIA advantage factor (Remark 4.2) -/

/-
**H2.4** (Remark 4.2, the `e^{-hm}` advantage): the SIRK bound (12) carries an
extra decay factor `e^{-hm} ≤ 1` compared with the SIA bound (15), so for any
nonnegative remainder magnitude `B` the SIRK bound `e^{-hm}·B` never exceeds the
SIA bound `B`.  (With `h, m > 0` the inequality is strict; `e^{-hm} < 1`.)
-/
theorem sirk_advantage_factor (h m B : ℝ) (hh : 0 ≤ h) (hm : 0 ≤ m) (hB : 0 ≤ B) :
    Real.exp (-(h * m)) * B ≤ B := by
  exact mul_le_of_le_one_left hB ( Real.exp_le_one_iff.mpr ( by nlinarith ) )

end

end BookProof.ChapterH2
