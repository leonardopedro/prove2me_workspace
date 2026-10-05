import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
import Mathlib


/-!
# The one-particle `R + αR²` Hamiltonian on the compactly supported smooth core

`CONSOLIDATED_PLAN.md` §10.6.1 asks for essential self-adjointness of the one-particle
gauge-fixed Hamiltonian `−Δ + W` on a dense core of `L²(ℝᵈ)`, and its §10.6.3 "definition of
done" names the Gauss–polynomial (Hermite) core.  For the *physics* the natural core is the
smaller one of **smooth compactly supported** functions: essential self-adjointness there is
strictly stronger (a smaller core means fewer test vectors in the deficiency equation), it
implies the statement on every larger core, and it is the core one uses when second
quantizing, since the finite-particle Fock core is built from it.

This module proves that statement, by transporting the Gauss-core theorems of
`BookProof.ChapterHermiteQuadraticEsa` down to the compactly supported core.

## The mechanism

`deficiencyTrivialAt_of_graphApprox` is the abstract step: if every vector of a domain `D₁`
is approximated, in the graph norm, by vectors of a *possibly unrelated* domain `D₂`, then
triviality of the deficiency spaces on `D₁` implies triviality on `D₂`.  (The corresponding
statement for `D₂ ≤ D₁` is `FarisLavine.essentiallySelfAdjointOn_restrict_of_graph_core`;
here neither core contains the other, since a Gauss polynomial is never compactly
supported.)

The analytic input is the cut-off estimate: for `ψ = p(x)e^{−‖x‖²/4}` and `χ_R(x) = χ(x/R)`
a scaled bump,

`(−Δ + W)(χ_R ψ) − (−Δ + W)ψ = (χ_R − 1)(−Δψ + Wψ) − 2∑ⱼ ∂ⱼχ_R ∂ⱼψ − (Δχ_R) ψ`,

whose three terms are `o(1)` in `L²`: the first by dominated convergence, the second and
third because `‖∂χ_R‖ ≤ C/R` and `‖∂²χ_R‖ ≤ C/R²` while `∂ⱼψ, ψ ∈ L²`.

## What is proved

* `ccHam` — the Hamiltonian `−Δ + W` on the compactly supported smooth core `ccDomain`,
  with `ccHam_symmetricOn`;
* `exists_cc_graph_approx` — the cut-off approximation;
* `ccHam_essentiallySelfAdjoint_of_core` — the transfer theorem;
* **`qgOneParticleCc_esa`** — `−Δ + ‖x‖²/4 + V` is essentially self-adjoint on the compactly
  supported smooth core of `L²(ℝᵈ)` for every smooth `V` with `|V| ≤ a‖x‖²/4 + b`, `a < 1`,
  with **`qgOneParticleCc_stone_flow`** its unitary group;
* `confVCc_esa`, `sectorQuadCc_esa` — the conformal-mode (`d = 1`) and reduced
  two-variable-sector (`d = 2`) instances of the gauge-fixed `R + αR²` Hamiltonian;
* `qgFockCc_esa` — the finite-particle statement: the `n`-particle Hamiltonian
  `∑ₖ (−Δ_k + W(x_k))` on `L²((ℝᵈ)ⁿ)` is of the same form, so it too is essentially
  self-adjoint on the compactly supported smooth core.

**Honest boundary.**  The potential class is the quadratic one of
`BookProof.ChapterHermiteQuadraticEsa` (the harmonic conformal-mode parabola plus a
strictly subquadratic perturbation).  The exponentially growing scalaron wall is *not*
covered: what is transported here is exactly what the Gauss core provides.
-/

namespace BookProof.QgOneParticleCc

open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

/-! ## 1. The abstract transfer step -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]





end Abstract

/-! ## 2. The Hamiltonian on the compactly supported smooth core -/

variable {d : ℕ}

/-- The `j`-th coordinate direction of `ℝᵈ`. -/
def kinDir (d : ℕ) (j : Fin d) : Vd d := EuclideanSpace.single j (1 : ℝ)

/-- The (negative) Laplacian `−Δ = −∑ⱼ ∂ⱼ²` as an operator on Schwartz space. -/
def kinOp (d : ℕ) : 𝓢(Vd d, ℂ) →L[ℂ] 𝓢(Vd d, ℂ) :=
  constCoeffOp (fun _ : Fin d => (-1 : ℝ)) (kinDir d) 0

/-- The kinetic term on the compactly supported smooth core. -/
def kinCc (d : ℕ) : ccDomain (Vd d) →ₗ[ℂ] L2d d :=
  opL2 (kinOp d) ∘ₗ Submodule.inclusion (ccDomain_le_schwartzDomain (E := Vd d))

/-- **The one-particle Hamiltonian `−Δ + W` on the compactly supported smooth core** of
`L²(ℝᵈ)`, for an arbitrary smooth real potential `W`. -/
def ccHam (W : Vd d → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    ccDomain (Vd d) →ₗ[ℂ] L2d d :=
  kinCc d + opCc W hW





/-! ## 3. Pointwise calculus: the Laplacian in coordinates -/

/-- The `j`-th coordinate derivative of a function on `ℝᵈ`. -/
def dcoord (j : Fin d) (u : Vd d → ℂ) (x : Vd d) : ℂ := fderiv ℝ u x (kinDir d j)

/-- The Laplacian in coordinates. -/
def lapC (u : Vd d → ℂ) (x : Vd d) : ℂ := ∑ j : Fin d, dcoord j (dcoord j u) x















/-! ## 4. The Gauss–polynomial core is smooth, with algebraic derivatives -/

theorem contDiff_polyEval (p : MvPolynomial (Fin d) ℂ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      (fun x : Vd d => MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p) := by
  induction p using MvPolynomial.induction_on with
  | C a => simpa using contDiff_const
  | add p q hp hq => simpa using hp.add hq
  | mul_X p i hp =>
      simp only [map_mul, MvPolynomial.eval_X]
      refine hp.mul ?_
      exact Complex.ofRealCLM.contDiff.comp
        ((EuclideanSpace.proj (𝕜 := ℝ) i).contDiff)

theorem contDiff_gaussD (d : ℕ) : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (gaussD (d := d)) := by
  unfold gaussD
  exact Real.contDiff_exp.comp (((contDiff_norm_sq ℝ).neg).div_const 4)

theorem contDiff_pgFun (p : MvPolynomial (Fin d) ℂ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (pgFun p) :=
  (contDiff_polyEval p).mul (Complex.ofRealCLM.contDiff.comp (contDiff_gaussD d))









/-! ## 5. The scaled cut-off family -/

/-- A fixed smooth bump: `1` on the unit ball, `0` outside the ball of radius `2`. -/
def bump (d : ℕ) : Vd d → ℝ := Classical.choose (exists_smooth_cutoff (V := Vd d) 1)

theorem bump_spec (d : ℕ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (bump d) ∧ HasCompactSupport (bump d) ∧
      (∀ x : Vd d, ‖x‖ ≤ 1 → bump d x = 1) ∧ (∀ x : Vd d, bump d x ∈ Set.Icc (0 : ℝ) 1) ∧
      (∀ x : Vd d, 1 + 1 ≤ ‖x‖ → bump d x = 0) ∧ ∃ C : ℝ, ∀ x, ‖gradient (bump d) x‖ ≤ C :=
  Classical.choose_spec (exists_smooth_cutoff (V := Vd d) 1)

/-- The rescaled cut-off `χ_R(x) = χ(x/R)`. -/
def cut (d : ℕ) (R : ℝ) : Vd d → ℝ := fun x => bump d (R⁻¹ • x)

theorem contDiff_cut (R : ℝ) : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cut d R) :=
  (bump_spec d).1.comp (contDiff_id.const_smul (R⁻¹))

theorem hasCompactSupport_cut {R : ℝ} (hR : 0 < R) : HasCompactSupport (cut d R) := by
  have h := (bump_spec d).2.1
  have hne : (R⁻¹ : ℝ) ≠ 0 := by positivity
  have hc : HasCompactSupport (fun x : Vd d => bump d (R⁻¹ • x)) := h.comp_smul hne
  exact hc





/-- The scaling `x ↦ x/R`, as a continuous linear map. -/
def scaleCLM (d : ℕ) (R : ℝ) : Vd d →L[ℝ] Vd d := R⁻¹ • ContinuousLinearMap.id ℝ (Vd d)

@[simp] theorem scaleCLM_apply (R : ℝ) (x : Vd d) : scaleCLM d R x = R⁻¹ • x := rfl













/-! ## 6. The cut-off approximation of a Gauss-core vector -/

/-- The cut-off of a core vector. -/
def cutFun (R : ℝ) (p : MvPolynomial (Fin d) ℂ) : Vd d → ℂ :=
  fun x => ((cut d R x : ℝ) : ℂ) * pgFun p x

theorem contDiff_cutFun (R : ℝ) (p : MvPolynomial (Fin d) ℂ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cutFun R p) :=
  (Complex.ofRealCLM.contDiff.comp (contDiff_cut R)).mul (contDiff_pgFun p)

theorem hasCompactSupport_cutFun {R : ℝ} (hR : 0 < R) (p : MvPolynomial (Fin d) ℂ) :
    HasCompactSupport (cutFun R p) := by
  have h : HasCompactSupport (fun x : Vd d => ((cut d R x : ℝ) : ℂ)) :=
    (hasCompactSupport_cut hR).comp_left (g := fun r : ℝ => (r : ℂ)) (by simp)
  exact h.mul_right

/-- The cut-off of a core vector, as an element of the compactly supported smooth core. -/
def cutCore (R : ℝ) (hR : 0 < R) (p : MvPolynomial (Fin d) ℂ) : ccSchwartz (Vd d) :=
  ⟨(hasCompactSupport_cutFun hR p).toSchwartzMap (contDiff_cutFun R p),
    hasCompactSupport_cutFun hR p⟩

@[simp] theorem cutCore_apply (R : ℝ) (hR : 0 < R) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    ((cutCore R hR p : ccSchwartz (Vd d)) : 𝓢(Vd d, ℂ)) x
      = ((cut d R x : ℝ) : ℂ) * pgFun p x := rfl

/-! ### `L²` tails -/





/-! ### The cut-off is locally constant inside the ball -/







/-! ### Representatives of the two Hamiltonians -/







/-! ### The pointwise error of the cut-off -/

/-- The square-integrable majorant of all the cut-off error terms. -/
def majorant (W : Vd d → ℝ) (K : ℝ) (p : MvPolynomial (Fin d) ℂ) (z : Vd d) : ℝ :=
  ‖pgFun (kinPoly p) z‖ + K * ‖pgFun p z‖
    + 2 * K * (∑ j : Fin d, ‖pgFun (coreD j p) z‖) + ‖((W z : ℝ) : ℂ) * pgFun p z‖







/-- The pointwise graph error made by cutting a Gauss-core vector off at radius `R`. -/
def cutErr (W : Vd d → ℝ) (R : ℝ) (p : MvPolynomial (Fin d) ℂ) (z : Vd d) : ℂ :=
  (((cut d R z : ℝ) : ℂ) - 1) * pgFun (kinPoly p) z
    - pgFun p z * lapC (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z
    - 2 * ∑ j : Fin d,
        dcoord j (fun y : Vd d => ((cut d R y : ℝ) : ℂ)) z * pgFun (coreD j p) z
    + (((cut d R z : ℝ) : ℂ) - 1) * (((W z : ℝ) : ℂ) * pgFun p z)











/-! ## 7. The transfer theorem and the `R + αR²` instances -/



theorem contDiff_harmW (d : ℕ) : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (harmW (d := d)) := by
  unfold harmW
  exact (contDiff_norm_sq ℝ).div_const 4





/-! ## 8. The gauge-fixed `R + αR²` instances on the compactly supported core -/

















/-! ## 9. The `n`-particle sector and the finite-particle Fock space

The `n`-particle configuration space is `(ℝᵈ)ⁿ = ℝ^{n·d}`, and the `n`-particle Hamiltonian
is `∑ₖ (−Δ_k + U(x_k))`.  Its kinetic part is the full Laplacian of `ℝ^{n·d}` and, when
`U = ‖·‖²/4 + V`, its potential is again `‖x‖²/4 + (a subquadratic perturbation)` — with the
*same* constant `a` — so the one-particle theorem applies verbatim in dimension `n·d`.  The
finite-particle Fock space is the `ℓ²`-direct sum of the sectors, and essential
self-adjointness is fibrewise (`BookProof.DirectSumEsa`). -/

/-- The `k`-th particle's coordinates, as a linear map `ℝ^{n·d} → ℝᵈ`. -/
def partLM (n d : ℕ) (k : Fin n) : Vd (n * d) →ₗ[ℝ] Vd d where
  toFun x := (WithLp.toLp 2 (fun i : Fin d => x (finProdFinEquiv (k, i))) : Vd d)
  map_add' x y := by ext i; simp
  map_smul' c x := by ext i; simp

@[simp] theorem partLM_apply (n d : ℕ) (k : Fin n) (x : Vd (n * d)) (i : Fin d) :
    (partLM n d k x) i = x (finProdFinEquiv (k, i)) := rfl

theorem contDiff_partLM (n d : ℕ) (k : Fin n) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (partLM n d k) :=
  (LinearMap.toContinuousLinearMap (partLM n d k)).contDiff



/-- The `n`-particle potential built from a one-particle potential `U`. -/
def nParticleW (U : Vd d → ℝ) (n : ℕ) : Vd (n * d) → ℝ :=
  fun x => ∑ k : Fin n, U (partLM n d k x)

theorem contDiff_nParticleW {U : Vd d → ℝ} (hU : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) U)
    (n : ℕ) : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (nParticleW U n) := by
  exact ContDiff.sum fun k _ => hU.comp (contDiff_partLM n d k)







/-- **The finite-particle Fock space** over the `d`-dimensional one-particle sector. -/
abbrev qgFock (d : ℕ) := lp (fun n : ℕ => L2d (n * d)) 2

/-- The Fock core: the algebraic direct sum of the compactly supported smooth sector
cores. -/
def qgFockCore (d : ℕ) : Submodule ℂ (qgFock d) :=
  dsCore (fun n : ℕ => ccDomain (Vd (n * d)))



/-- **The second-quantised `R + αR²` Hamiltonian** on the finite-particle Fock space: on the
`n`-particle sector it is `∑ₖ (−Δ_k + ‖x_k‖²/4 + V(x_k))`. -/
def qgFockHam {V : Vd d → ℝ} (hVs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    qgFockCore d →ₗ[ℂ] qgFock d :=
  dsOp fun n : ℕ => ccHam (nParticleW (fun y => harmW y + V y) n)
    (contDiff_nParticleW ((contDiff_harmW d).add hVs) n)







end

end BookProof.QgOneParticleCc
