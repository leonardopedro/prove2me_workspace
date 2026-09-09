import Mathlib
import BookProof.ChapterStoneBridge

/-!
# Explicit dynamics on eigenvectors: the Stone flow acts by a phase

`BookProof.ChapterStoneBridge` produces, from essential self-adjointness of a symmetric
operator `Hc` on a dense core `D`, a self-adjoint extension `T` and a complete unitary
flow `U` solving the Schrödinger equation `d/dt (U t x) = −i T (U t x)`
(`BookProof.StoneBridge.exists_stone_flow_of_esa`).  That statement is an *existence*
statement: it says nothing about what the flow does to a concrete vector.

For all the Hamiltonians of the quadratic family in this development the core carries an
orthonormal *total family of eigenvectors* — the (translated, modulated, rotated) product
Hermite functions — and on such a vector the dynamics must be explicit.  This module proves
that it is:

* `isSelfAdjointExtension_eigenvector` — a self-adjoint extension of `Hc` still has `ψ` as
  an eigenvector, with the same eigenvalue;
* `stoneFlow_apply_eigenvector` — **the headline**: if `T ψ = λψ` with `λ` real and `U` is
  *any* Stone flow for `T`, then `U t ψ = e^{−iλt} ψ` for every `t`;
* `stoneFlow_apply_core_eigenvector` — the two combined, stated for an eigenvector of the
  core operator;
* `exists_diagonal_stone_flow` — for a densely defined symmetric essentially self-adjoint
  operator with *any* family of eigenvectors in the core, a flow exists which acts on each
  of them by the corresponding phase.

The proof of the headline does not use the spectral theorem.  Writing
`φ(t) = ⟪ψ, U t ψ⟫`, the Schrödinger equation and symmetry of `T` give the scalar ODE
`φ' = −iλφ`, so `φ(t) = e^{−iλt}‖ψ‖²`; since `U t` is isometric this is the equality case
of the Cauchy–Schwarz inequality, i.e. `‖U t ψ − e^{−iλt}ψ‖ = 0`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped InnerProductSpace

namespace BookProof.StoneEigenflow

open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **A self-adjoint extension keeps the eigenvectors of the core operator.**  If
`Hc ψ = λψ` on the core, then `ψ` lies in the domain of the extension and is an
eigenvector there, with the same eigenvalue. -/
theorem isSelfAdjointExtension_eigenvector {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsSelfAdjointExtension Hc A) (x : D) {lam : ℂ}
    (hx : Hc x = lam • (x : F)) :
    ∃ hmem : (x : F) ∈ Dom, A ⟨(x : F), hmem⟩ = lam • (x : F) := by
  obtain ⟨hmem, heq⟩ := h.1 x
  exact ⟨hmem, by rw [heq, hx]⟩

/-- **The headline.**  A Stone flow of a self-adjoint operator acts on an eigenvector by
the corresponding phase: if `T ψ = λψ` with `λ ∈ ℝ`, then `U t ψ = e^{−iλt} ψ`.

No spectral theorem is used: the scalar function `φ(t) = ⟪ψ, U t ψ⟫` solves `φ' = −iλφ`
by the Schrödinger equation and symmetry of `T`, and the conclusion is the equality case
of Cauchy–Schwarz for the isometry `U t`. -/
theorem stoneFlow_apply_eigenvector {T : UnboundedSelfAdjoint F} {U : ℝ → (F →L[ℂ] F)}
    (hU : IsStoneFlow T U) {x : F} (hx : x ∈ T.domain) {lam : ℝ}
    (hev : T.op ⟨x, hx⟩ = (lam : ℂ) • x) (t : ℝ) :
    U t x = Complex.exp (-(Complex.I * lam * t)) • x := by
  obtain ⟨hU0, -, hiso, hflow⟩ := hU
  set φ : ℝ → ℂ := fun s => ⟪x, U s x⟫_ℂ with hφ
  have hderiv : ∀ s : ℝ, HasDerivAt φ (-(Complex.I * lam) * φ s) s := by
    intro s
    obtain ⟨h, hd⟩ := hflow x hx s
    have hL : HasDerivAt φ (⟪x, (-Complex.I) • T.op ⟨U s x, h⟩⟫_ℂ) s := by
      have := ((innerSL ℂ x).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt s hd
      simpa [hφ] using this
    have hval : (⟪x, (-Complex.I) • T.op ⟨U s x, h⟩⟫_ℂ) = -(Complex.I * lam) * φ s := by
      rw [inner_smul_right]
      have hs := T.symmetric ⟨x, hx⟩ ⟨U s x, h⟩
      simp only at hs
      rw [hev] at hs
      rw [← hs, inner_smul_left]
      simp [hφ]
      ring
    rwa [hval] at hL
  -- `g s = e^{iλs} φ(s)` has vanishing derivative, hence is constant.
  set g : ℝ → ℂ := fun s => Complex.exp (Complex.I * lam * s) * φ s with hg
  have hgderiv : ∀ s : ℝ, HasDerivAt g 0 s := by
    intro s
    have h1 : HasDerivAt (fun s : ℝ => Complex.I * lam * (s : ℂ)) (Complex.I * lam) s := by
      simpa using ((Complex.ofRealCLM.hasDerivAt (x := s)).const_mul (Complex.I * lam))
    have h2 := (h1.cexp).mul (hderiv s)
    simpa [hg] using h2.congr_deriv (by ring)
  have hconst : g t = g 0 :=
    is_const_of_fderiv_eq_zero (fun s => (hgderiv s).differentiableAt)
      (fun s => by simpa using (hgderiv s).hasFDerivAt.fderiv) t 0
  set e : ℂ := Complex.exp (-(Complex.I * lam * t)) with he
  have hg0 : g 0 = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    simp [hg, hφ, hU0, inner_self_eq_norm_sq_to_K]
  have hexp : Complex.exp (Complex.I * lam * t) * e = 1 := by
    rw [he, ← Complex.exp_add]; simp
  have hφt : φ t = e * ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    have hct : Complex.exp (Complex.I * lam * t) * φ t = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
      rw [← hg0, ← hconst]
    calc φ t = (e * Complex.exp (Complex.I * lam * t)) * φ t := by
          rw [mul_comm e, hexp]; ring
      _ = e * ((‖x‖ ^ 2 : ℝ) : ℂ) := by rw [mul_assoc, hct]
  have hnorme : ‖e‖ = 1 := by
    rw [he, Complex.norm_exp]; simp
  have hconj : (starRingEnd ℂ) e * e = 1 := by
    rw [he, ← Complex.exp_conj, ← Complex.exp_add]; simp
  have hinner : ⟪U t x, e • x⟫_ℂ = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_smul_right, ← inner_conj_symm]
    change e * (starRingEnd ℂ) (φ t) = _
    rw [hφt, map_mul]
    calc e * ((starRingEnd ℂ) e * (starRingEnd ℂ) ((‖x‖ ^ 2 : ℝ) : ℂ))
        = ((starRingEnd ℂ) e * e) * ((‖x‖ ^ 2 : ℝ) : ℂ) := by
          rw [Complex.conj_ofReal]; ring
      _ = ((‖x‖ ^ 2 : ℝ) : ℂ) := by rw [hconj]; ring
  have hz : ‖U t x - e • x‖ ^ 2 = 0 := by
    rw [norm_sub_sq (𝕜 := ℂ), hinner, hiso, norm_smul, hnorme,
      show RCLike.re ((‖x‖ ^ 2 : ℝ) : ℂ) = ‖x‖ ^ 2 from Complex.ofReal_re _]
    ring
  exact sub_eq_zero.mp (norm_eq_zero.mp (pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hz))

/-- **Explicit dynamics for an eigenvector of the core operator.**  If `Hc ψ = λψ` on the
core with `λ` real, `T` is a self-adjoint extension of `Hc` and `U` is a Stone flow for
`T`, then `U t ψ = e^{−iλt} ψ`: the Schrödinger equation with initial datum `ψ` is solved
in closed form. -/
theorem stoneFlow_apply_core_eigenvector {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {T : UnboundedSelfAdjoint F} {U : ℝ → (F →L[ℂ] F)}
    (hext : IsSelfAdjointExtension Hc T.op) (hU : IsStoneFlow T U) (x : D) {lam : ℝ}
    (hx : Hc x = (lam : ℂ) • (x : F)) (t : ℝ) :
    U t (x : F) = Complex.exp (-(Complex.I * lam * t)) • (x : F) := by
  obtain ⟨hmem, heq⟩ := isSelfAdjointExtension_eigenvector hext x hx
  exact stoneFlow_apply_eigenvector hU hmem heq t

/-- **A diagonal Stone flow.**  A densely defined symmetric essentially self-adjoint core
operator with a family `ψ : ι → D` of eigenvectors, with real eigenvalues `lam`, generates
a complete unitary flow which acts on each `ψ α` by the phase `e^{−i lam α t}`. -/
theorem exists_diagonal_stone_flow [CompleteSpace F] {D : Submodule ℂ F} (Hc : D →ₗ[ℂ] F)
    (hdense : Dense ((D : Submodule ℂ F) : Set F)) (hsym : SymmetricOn D Hc)
    (hesa : EssentiallySelfAdjointOn D Hc) {ι : Type*} (psi : ι → D) (lam : ι → ℝ)
    (hev : ∀ α, Hc (psi α) = ((lam α : ℝ) : ℂ) • ((psi α : F))) :
    ∃ (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)),
      IsSelfAdjointExtension Hc T.op ∧ IsStoneFlow T U ∧
        ∀ (α : ι) (t : ℝ),
          U t ((psi α : F)) = Complex.exp (-(Complex.I * lam α * t)) • ((psi α : F)) := by
  obtain ⟨T, U, hext, hU⟩ := exists_stone_flow_of_esa Hc hdense hsym hesa
  exact ⟨T, U, hext, hU, fun α t =>
    stoneFlow_apply_core_eigenvector hext hU (psi α) (hev α) t⟩

end BookProof.StoneEigenflow
