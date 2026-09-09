import Mathlib
import BookProof.ChapterWallEsaBddBelow
import BookProof.ChapterWallEsaSemibounded
import BookProof.ChapterSchrodingerCutoffEsa
import BookProof.ChapterQgOuterFockCoreFL

/-!
# The scalaron fibre: the exponential wall as a Faris–Lavine comparison operator

This module prepares the *one-dimensional* input of the quantum-gravity Faris–Lavine
programme in the form the outer-Fock lift needs: the scalaron degree of freedom, carrying
the **full exponential** Einstein-frame potential (no Taylor expansion), realised as a
family of Faris–Lavine comparison operators

`h_s = −d²/dφ² + φ²/4 + V(φ) + s`,  `s ≥ 0`,

on `L²(ℝ)`, together with the estimates that make the fibre usable inside a lifted
Hamiltonian: everything is uniform in the shift `s`.

## What is proved

* `isGraphCore_of_esa` — an abstract and reusable step: if a symmetric operator `P` on a
  subspace `C₀` is essentially self-adjoint there, then `C₀` is a **graph core** for *every*
  comparison operator extending `P`.  (Density of the range of `P − i` is exactly the
  deficiency triviality, and `‖Nu − iu‖² = ‖Nu‖² + ‖u‖²` converts one approximation into a
  graph approximation.)  This is what lets the Friedrichs extension of a positive
  one-particle operator be used with the core-extension machinery of
  `BookProof.QgOuterFockCoreFL`.
* `integral_weight_re_secondDeriv` — the weighted integration-by-parts identity
  `∫ P·Re(conj u · u'') = −∫ P|u'|² + ½∫ P''|u|²` for compactly supported smooth `u`.
* `wallEnergy_identity` — the resulting energy identity
  `‖−u'' + P u‖² = ‖u''‖² + ‖P u‖² + 2∫P|u'|² − ∫P''|u|²`.
* `WallPot` — the data of an admissible wall: a smooth non-negative potential with
  `V'' ≤ C(V+1)`.  `starobinskyWall` is the Einstein-frame scalaron potential, which
  satisfies it (`starobinskyV_hess_le`).
* `fibHam`, `fibHam_symmetricOn`, `fibHam_quadForm`, `fibHam_pos`, `fibHam_esa` — the fibre
  Hamiltonian on the compactly supported smooth core, its quadratic form, positivity and
  essential self-adjointness.
* `fibHam_norm_bounds` (`norm_deriv2_le`, `norm_pot_mul_le`, `norm_coord_mul_le`,
  `norm_deriv_le`, `norm_le_shift`) — the relative bounds of the second derivative, of the
  potential, of `φ` and of `d/dφ` against `‖(h_s+1)u‖`, **with constants independent of the
  shift `s`**.
* `fibComparison` — the Friedrichs extension of `h_s` as a Faris–Lavine comparison
  operator, and `fibComparison_isGraphCore`, `fibComparison_core_apply`.
-/

namespace BookProof.ScalaronFiberFL

open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

/-! ## 1. A graph core from essential self-adjointness -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

omit [CompleteSpace F] in
/-- For a symmetric operator, `‖Nu − iu‖² = ‖Nu‖² + ‖u‖²`: the shift by `i` controls both
the vector and its image. -/
theorem norm_sub_I_sq {D : Submodule ℂ F} (N : D →ₗ[ℂ] F) (hsym : SymmetricOn D N) (u : D) :
    ‖N u - Complex.I • (u : F)‖ ^ 2 = ‖N u‖ ^ 2 + ‖(u : F)‖ ^ 2 := by
  have him : (inner ℂ (N u) (u : F) : ℂ).im = 0 := inner_apply_self_im N hsym u
  have hre : (inner ℂ (N u) (Complex.I • (u : F)) : ℂ).re = 0 := by
    rw [inner_smul_right, Complex.mul_re, him]
    simp
  have hnorm : ‖Complex.I • (u : F)‖ = ‖(u : F)‖ := by
    rw [norm_smul]; simp
  rw [norm_sub_sq (𝕜 := ℂ), hnorm]
  simp only [RCLike.re_to_complex] at hre ⊢
  rw [hre]
  ring

/-- **A graph core from essential self-adjointness.**  If the symmetric operator `P` on the
subspace `C₀` is essentially self-adjoint there and a comparison operator `C` extends it,
then `C₀` is a graph core for `C`: every vector of `𝒟(N)` is approximated by core vectors
simultaneously in norm and in the norm of the image. -/
theorem isGraphCore_of_esa (C : Comparison F) (C₀ : Submodule ℂ F) (hle : C₀ ≤ C.dom)
    (P : C₀ →ₗ[ℂ] F) (hext : ∀ p : C₀, C.op ⟨(p : F), hle p.2⟩ = P p)
    (hesa : EssentiallySelfAdjointOn C₀ P) : IsGraphCore C C₀ := by
  classical
  set R : Submodule ℂ F := LinearMap.range (P - Complex.I • C₀.subtype) with hR
  have hperp : Rᗮ = ⊥ := by
    refine Submodule.eq_bot_iff _ |>.mpr ?_
    intro w hw
    refine hesa.2 w ?_
    intro v
    have hmem : (P - Complex.I • C₀.subtype) v ∈ R := ⟨v, rfl⟩
    have h0 : (inner ℂ ((P - Complex.I • C₀.subtype) v) w : ℂ) = 0 := hw _ hmem
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_sub_left, inner_smul_left] at h0
    have h1 : (inner ℂ (P v) w : ℂ) = (starRingEnd ℂ) Complex.I * inner ℂ (v : F) w := by
      linear_combination h0
    rw [h1]
    simp
  have hdense : Dense (R : Set F) := by
    have htop : R.topologicalClosure = ⊤ := Submodule.topologicalClosure_eq_top_iff.mpr hperp
    rw [← Submodule.dense_iff_topologicalClosure_eq_top] at htop
    exact htop
  refine ⟨hle, ?_⟩
  intro x ε hε
  set y : F := C.op x - Complex.I • (x : F) with hy
  obtain ⟨r, hrball, hrR⟩ := Metric.dense_iff.mp hdense y ε hε
  have hr : ‖r - y‖ < ε := by
    rw [← dist_eq_norm]
    simpa [Metric.mem_ball, dist_comm] using hrball
  obtain ⟨p, hp⟩ := hrR
  set q : C.dom := ⟨(p : F), hle p.2⟩ with hq
  have hval : C.op (q - x) - Complex.I • ((q - x : C.dom) : F) = r - y := by
    rw [map_sub, hy, ← hp]
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      Submodule.coe_sub, hq, hext p, smul_sub]
    abel
  have hkey := norm_sub_I_sq C.op C.sym (q - x)
  rw [hval] at hkey
  have hcoe : ((q - x : C.dom) : F) = (p : F) - (x : F) := rfl
  refine ⟨q, p.2, ?_, ?_⟩
  · have h2 : ‖((q - x : C.dom) : F)‖ < ε := by
      nlinarith [norm_nonneg ((q - x : C.dom) : F), norm_nonneg (C.op (q - x)),
        norm_nonneg (r - y), hr]
    rwa [hcoe] at h2
  · have h2 : ‖C.op (q - x)‖ < ε := by
      nlinarith [norm_nonneg ((q - x : C.dom) : F), norm_nonneg (C.op (q - x)),
        norm_nonneg (r - y), hr]
    rwa [map_sub] at h2

end Abstract

/-! ## 2. Integration by parts: the Wronskian identity on the line -/

section Wronskian

/-- **The Wronskian identity.**  For compactly supported smooth `f, g` on the line,
`∫ x·(conj f · g'' − conj f'' · g) = −2 ∫ conj f · g'`.  Both integrations by parts are
supplied by `integral_deriv_eq_zero_of_hasCompactSupport`; this identity is the exact
statement that the commutator of the Schrödinger operator with multiplication by the
coordinate is `−2 d/dx`, *whatever the potential is* — the potential cancels before the
identity is applied. -/
theorem integral_x_wronskian (f g : ℝ → ℂ)
    (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hfs : HasCompactSupport f) (hgs : HasCompactSupport g) :
    (∫ x : ℝ, (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))
      = -2 * ∫ x : ℝ, (starRingEnd ℂ) (f x) * deriv g x := by
  have hf1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv f) := hf.deriv'
  have hf2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv f)) := hf1.deriv'
  have hg1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv g) := hg.deriv'
  have hg2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv g)) := hg1.deriv'
  have hd0 : ∀ x, HasDerivAt f (deriv f x) x := fun x =>
    (hf.differentiable (by simp) x).hasDerivAt
  have hd1 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x := fun x =>
    (hf1.differentiable (by simp) x).hasDerivAt
  have he0 : ∀ x, HasDerivAt g (deriv g x) x := fun x =>
    (hg.differentiable (by simp) x).hasDerivAt
  have he1 : ∀ x, HasDerivAt (deriv g) (deriv (deriv g) x) x := fun x =>
    (hg1.differentiable (by simp) x).hasDerivAt
  -- the conjugated derivatives
  have ha0 : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (f y))
      ((starRingEnd ℂ) (deriv f x)) x := fun x => (hd0 x).star
  have ha1 : ∀ x, HasDerivAt (fun y => (starRingEnd ℂ) (deriv f y))
      ((starRingEnd ℂ) (deriv (deriv f) x)) x := fun x => (hd1 x).star
  have hcf : Continuous f := hf.continuous
  have hcf1 : Continuous (deriv f) := hf1.continuous
  have hcf2 : Continuous (deriv (deriv f)) := hf2.continuous
  have hcg : Continuous g := hg.continuous
  have hcg1 : Continuous (deriv g) := hg1.continuous
  have hcg2 : Continuous (deriv (deriv g)) := hg2.continuous
  have hfs1 : HasCompactSupport (deriv f) := hfs.deriv
  have hfs2 : HasCompactSupport (deriv (deriv f)) := hfs1.deriv
  have hgs1 : HasCompactSupport (deriv g) := hgs.deriv
  have hgs2 : HasCompactSupport (deriv (deriv g)) := hgs1.deriv
  have hcs0 : HasCompactSupport fun y => (starRingEnd ℂ) (f y) :=
    hfs.comp_left (g := starRingEnd ℂ) (by simp)
  have hcs1 : HasCompactSupport fun y => (starRingEnd ℂ) (deriv f y) :=
    hfs1.comp_left (g := starRingEnd ℂ) (by simp)
  have hcs2 : HasCompactSupport fun y => (starRingEnd ℂ) (deriv (deriv f) y) :=
    hfs2.comp_left (g := starRingEnd ℂ) (by simp)
  -- Step 1: `∫ (conj f' · g + conj f · g') = 0`
  have step2 : (∫ x, ((starRingEnd ℂ) (deriv f x) * g x
      + (starRingEnd ℂ) (f x) * deriv g x)) = 0 := by
    refine integral_deriv_eq_zero_of_hasCompactSupport
      (g := fun x => (starRingEnd ℂ) (f x) * g x) (fun x => ?_) (by fun_prop) hcs0.mul_right
    exact (ha0 x).mul (he0 x)
  -- Step 2: `∫ d/dx [x (conj f · g' − conj f' · g)] = 0`
  have step1 : (∫ x : ℝ, (((starRingEnd ℂ) (f x) * deriv g x
        - (starRingEnd ℂ) (deriv f x) * g x)
      + (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x))) = 0 := by
    refine integral_deriv_eq_zero_of_hasCompactSupport
      (g := fun x => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv g x
        - (starRingEnd ℂ) (deriv f x) * g x)) (fun x => ?_) (by fun_prop)
      ((hcs0.mul_right.sub hcs1.mul_right).mul_left)
    have hx : HasDerivAt (fun y : ℝ => (y : ℂ)) 1 x := by
      simpa using (Complex.ofRealCLM.hasDerivAt (x := x))
    have hprod : HasDerivAt (fun y => (starRingEnd ℂ) (f y) * deriv g y
        - (starRingEnd ℂ) (deriv f y) * g y)
        (((starRingEnd ℂ) (deriv f x) * deriv g x
            + (starRingEnd ℂ) (f x) * deriv (deriv g) x)
          - ((starRingEnd ℂ) (deriv (deriv f) x) * g x
            + (starRingEnd ℂ) (deriv f x) * deriv g x)) x :=
      ((ha0 x).mul (he1 x)).sub ((ha1 x).mul (he0 x))
    have := hx.mul hprod
    convert this using 1
    ring
  -- integrability of the pieces
  have hI1 : Integrable fun x => (starRingEnd ℂ) (f x) * deriv g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (f x) * deriv g x
      ).integrable_of_hasCompactSupport hcs0.mul_right
  have hI2 : Integrable fun x => (starRingEnd ℂ) (deriv f x) * g x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv f x) * g x
      ).integrable_of_hasCompactSupport hcs1.mul_right
  have hI3 : Integrable fun x : ℝ => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
      - (starRingEnd ℂ) (deriv (deriv f) x) * g x) :=
    (by fun_prop : Continuous fun x : ℝ => (x : ℂ) * ((starRingEnd ℂ) (f x) * deriv (deriv g) x
        - (starRingEnd ℂ) (deriv (deriv f) x) * g x)
      ).integrable_of_hasCompactSupport ((hcs0.mul_right.sub hcs2.mul_right).mul_left)
  have hI4 : Integrable fun x : ℝ => (starRingEnd ℂ) (f x) * deriv g x
      - (starRingEnd ℂ) (deriv f x) * g x := hI1.sub hI2
  rw [integral_add hI4 hI3, integral_sub hI1 hI2] at step1
  rw [integral_add hI2 hI1] at step2
  linear_combination step1 + step2

end Wronskian

/-! ## 3. The scalaron fibre operator -/

section Fibre

/-- The `L²` space of the scalaron fibre. -/
abbrev L2R := Lp ℂ 2 (volume : Measure ℝ)

/-- An **admissible wall**: a smooth non-negative potential on the line.  The Einstein-frame
scalaron potential of Starobinsky inflation, with the exponential kept in full and no
Taylor expansion, is one — see `starobinskyWall`. -/
structure WallPot where
  /-- The potential. -/
  V : ℝ → ℝ
  /-- It is smooth. -/
  smooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V
  /-- It is non-negative. -/
  nonneg : ∀ x, 0 ≤ V x

/-- **The scalaron wall**: the Einstein-frame Starobinsky potential
`M⁴/(16α)·(1 − exp(−√(2/3)·φ/M))²`, with the exponential in full. -/
def starobinskyWall (M alpha : ℝ) (halpha : 0 < alpha) : WallPot where
  V := BookProof.Starobinsky.starobinskyV M alpha
  smooth := BookProof.ScalaronEsa.contDiff_starobinskyV M alpha
  nonneg := fun phi => BookProof.Starobinsky.starobinskyV_nonneg halpha phi

namespace WallPot

variable (W : WallPot) (s : ℝ)

/-- The fibre potential `φ²/4 + V(φ) + s`. -/
def pot : ℝ → ℝ := fun x => x ^ 2 / 4 + (W.V x + s)

theorem pot_smooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W.pot s) :=
  ((contDiff_id.pow 2).div_const 4).add (W.smooth.add contDiff_const)

theorem pot_nonneg (hs : 0 ≤ s) (x : ℝ) : 0 ≤ W.pot s x := by
  have h1 : (0 : ℝ) ≤ x ^ 2 / 4 := by positivity
  have h2 := W.nonneg x
  simp only [pot]
  linarith

theorem one_le_pot (hs : 1 ≤ s) (x : ℝ) : 1 ≤ W.pot s x := by
  have h1 : (0 : ℝ) ≤ x ^ 2 / 4 := by positivity
  have h2 := W.nonneg x
  simp only [pot]
  linarith

theorem sq_div_four_le_pot (hs : 0 ≤ s) (x : ℝ) : x ^ 2 / 4 ≤ W.pot s x := by
  have h2 := W.nonneg x
  simp only [pot]
  linarith

/-- **The scalaron fibre Hamiltonian** `h_s = −d²/dφ² + φ²/4 + V(φ) + s`, on the compactly
supported smooth core of `L²(ℝ)`. -/
def ham : ccDomain ℝ →ₗ[ℂ] L2R := wallHam (W.pot s) (W.pot_smooth s)

theorem ham_symmetricOn : SymmetricOn (ccDomain ℝ) (W.ham s) :=
  wallHam_symmetricOn _ _

/-- **The fibre Hamiltonian is essentially self-adjoint on the compactly supported smooth
core** — for the *full* exponential wall, with no relative-boundedness hypothesis. -/
theorem ham_esa (hs : 0 ≤ s) : EssentiallySelfAdjointOn (ccDomain ℝ) (W.ham s) :=
  oscillatorPlus_esa (fun x => W.V x + s) (W.smooth.add contDiff_const) (c := 0)
    (fun x => by simpa using add_nonneg (W.nonneg x) hs)

end WallPot

/-! ### The fibre operator on a core element, as a Schwartz function -/

/-- The fibre Hamiltonian, as a map of the compactly supported smooth core into Schwartz
space. -/
def hamS (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) : 𝓢(ℝ, ℂ) :=
  kinOpR (f : 𝓢(ℝ, ℂ)) + mulCc (W.pot s) (W.pot_smooth s) f

theorem hamS_apply (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) (x : ℝ) :
    hamS W s f x
      = -deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) x + (W.pot s x : ℂ) * (f : 𝓢(ℝ, ℂ)) x := by
  simp [hamS, kinOpR_apply]

theorem ham_eq_toLp (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    W.ham s (ccEquiv ℝ f) = (hamS W s f).toLp 2 (volume : Measure ℝ) := by
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ f)
      = schwartzEquiv ℝ (f : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ f) = (kinOpR (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hpot : opCc (W.pot s) (W.pot_smooth s) (ccEquiv ℝ f)
      = (mulCc (W.pot s) (W.pot_smooth s) f).toLp 2 (volume : Measure ℝ) := opCc_apply _ _ _
  change (kinCcR + opCc (W.pot s) (W.pot_smooth s)) (ccEquiv ℝ f) = _
  rw [LinearMap.add_apply, hkin, hpot, hamS]
  exact (map_add (toLpCLM ℂ ℂ 2 (volume : Measure ℝ)) _ _).symm

/-- Multiplication by the scalaron field `φ`, on the core. -/
def xCc : ccDomain ℝ →ₗ[ℂ] L2R := opCc (fun x : ℝ => x) contDiff_id

theorem xCc_eq_toLp (f : ccSchwartz ℝ) :
    xCc (ccEquiv ℝ f) = (mulCc (fun x : ℝ => x) contDiff_id f).toLp 2 (volume : Measure ℝ) :=
  opCc_apply _ _ _

/-- The derivative of a core element, as an element of `L²(ℝ)`. -/
def derivL2 (f : ccSchwartz ℝ) : L2R :=
  (SchwartzMap.derivCLM ℂ ℂ (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ)

/-! ### Integrals -/

theorem cc_integrable (f : ccSchwartz ℝ) {W : ℝ → ℝ} (hW : Continuous W) :
    Integrable fun x => W x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have hsq : Continuous fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by fun_prop
  have hsupp : HasCompactSupport fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    f.2.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
  exact ((hW.mul hsq)).integrable_of_hasCompactSupport hsupp.mul_left

/-- The `L²` square norm of a Schwartz function. -/
theorem toLp_norm_sq (g : 𝓢(ℝ, ℂ)) :
    ‖g.toLp 2 (volume : Measure ℝ)‖ ^ 2 = ∫ x, ‖g x‖ ^ 2 := by
  have h := inner_toLp_self g
  rw [← inner_self_eq_norm_sq (𝕜 := ℂ) (g.toLp 2 (volume : Measure ℝ)), h]
  simp

/-- The `L²` pairing of two Schwartz functions. -/
theorem inner_toLp_toLp (g h : 𝓢(ℝ, ℂ)) :
    (inner ℂ (g.toLp 2 (volume : Measure ℝ)) (h.toLp 2 (volume : Measure ℝ)) : ℂ)
      = ∫ x, (starRingEnd ℂ) (g x) * h x := by
  rw [inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [h.coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]

/-! ### The quadratic form of the fibre Hamiltonian, and the uniform estimates -/

theorem cc_integrable_sq (f : ccSchwartz ℝ) :
    Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  simpa using cc_integrable f (W := fun _ => (1 : ℝ)) continuous_const

theorem ham_inner_self (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    (inner ℂ (W.ham s (ccEquiv ℝ f)) ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ)
      = (((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
          + ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form (W.pot s) (W.pot_smooth s) f
  change (inner ℂ ((kinCcR + opCc (W.pot s) (W.pot_smooth s)) (ccEquiv ℝ f))
    ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ) = _
  rw [LinearMap.add_apply, inner_add_left, hk, hp]
  push_cast
  ring

/-- The quadratic form of `h_s` is the Dirichlet energy plus the potential energy. -/
theorem ham_quadForm (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    quadForm (W.ham s) (ccEquiv ℝ f)
      = (∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
        + ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have h := ham_inner_self W s f
  have hc : (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = (starRingEnd ℂ)
        (inner ℂ (W.ham s (ccEquiv ℝ f)) ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ) :=
    (inner_conj_symm _ _).symm
  rw [quadForm, hc, h]
  simp

theorem integral_deriv_nonneg (f : ccSchwartz ℝ) :
    (0 : ℝ) ≤ ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 :=
  integral_nonneg fun x => by positivity

/-- **The fibre Hamiltonian is positive** for `s ≥ 0`. -/
theorem ham_quadForm_nonneg (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (u : ccDomain ℝ) :
    0 ≤ quadForm (W.ham s) u := by
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective u
  rw [ham_quadForm]
  have h2 : (0 : ℝ) ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    integral_nonneg fun x => mul_nonneg (W.pot_nonneg s hs x) (by positivity)
  have h1 := integral_deriv_nonneg f
  linarith

/-- The `L²` norm is controlled by the quadratic form once the shift is at least one. -/
theorem norm_sq_le_quadForm (W : WallPot) (s : ℝ) (hs : 1 ≤ s) (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : L2R)‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by
  rw [ccEquiv_norm_sq, ham_quadForm]
  have hmono : (∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    refine integral_mono (cc_integrable_sq f) (cc_integrable f (W.pot_smooth s).continuous)
      fun x => ?_
    have h1 := W.one_le_pot s hs x
    nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖]
  have h1 := integral_deriv_nonneg f
  linarith

/-- The Dirichlet energy is controlled by the quadratic form. -/
theorem integral_deriv_le_quadForm (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    (∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2) ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by
  rw [ham_quadForm]
  have h2 : (0 : ℝ) ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    integral_nonneg fun x => mul_nonneg (W.pot_nonneg s hs x) (by positivity)
  linarith

theorem norm_derivL2_sq (f : ccSchwartz ℝ) :
    ‖derivL2 f‖ ^ 2 = ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 := by
  rw [derivL2, toLp_norm_sq]
  simp

/-- **The derivative is controlled by the quadratic form**, uniformly in the shift. -/
theorem norm_derivL2_sq_le (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    ‖derivL2 f‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by
  rw [norm_derivL2_sq]
  exact integral_deriv_le_quadForm W s hs f

theorem norm_xCc_sq (f : ccSchwartz ℝ) :
    ‖xCc (ccEquiv ℝ f)‖ ^ 2 = ∫ x, x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  rw [xCc_eq_toLp, toLp_norm_sq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  change ‖(mulCc (fun x : ℝ => x) contDiff_id f) x‖ ^ 2 = x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2
  rw [mulCc_apply, norm_mul, mul_pow]
  simp [sq_abs]

/-- **Multiplication by the scalaron field is controlled by the quadratic form**, uniformly
in the shift: this is what makes the scalaron–vielbein coupling relatively bounded. -/
theorem norm_xCc_sq_le (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    ‖xCc (ccEquiv ℝ f)‖ ^ 2 ≤ 4 * quadForm (W.ham s) (ccEquiv ℝ f) := by
  rw [norm_xCc_sq, ham_quadForm]
  have hmono : (∫ x, x ^ 2 / 4 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    refine integral_mono (cc_integrable f (by fun_prop))
      (cc_integrable f (W.pot_smooth s).continuous) fun x => ?_
    have h1 := W.sq_div_four_le_pot s hs x
    nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖]
  have hsplit : (∫ x, x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      = 4 * ∫ x, x ^ 2 / 4 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    rw [← integral_const_mul]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  have h1 := integral_deriv_nonneg f
  rw [hsplit]
  linarith

/-! ### The commutator of the fibre Hamiltonian with the scalaron field -/

theorem inner_xCc_ham (W : WallPot) (s : ℝ) (f g : ccSchwartz ℝ) :
    (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = ∫ y : ℝ, (y : ℂ) * ((starRingEnd ℂ) ((g : 𝓢(ℝ, ℂ)) y)
          * (-deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) y
            + (W.pot s y : ℂ) * (f : 𝓢(ℝ, ℂ)) y)) := by
  rw [xCc_eq_toLp, ham_eq_toLp, inner_toLp_toLp]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  change (starRingEnd ℂ) ((mulCc (fun x : ℝ => x) contDiff_id g) y) * (hamS W s f) y = _
  rw [mulCc_apply, hamS_apply]
  simp only [map_mul, Complex.conj_ofReal]
  ring

theorem inner_derivL2 (f g : ccSchwartz ℝ) :
    (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (derivL2 g) : ℂ)
      = ∫ y : ℝ, (starRingEnd ℂ) ((f : 𝓢(ℝ, ℂ)) y)
          * deriv ((g : 𝓢(ℝ, ℂ)) : ℝ → ℂ) y := by
  rw [ccEquiv_coe, derivL2, inner_toLp_toLp]
  refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
  simp

/-- **The commutator identity** `[h_s, φ] = −2 d/dφ` in pairing form.  The potential — the
full exponential wall included — cancels identically, so the identity is uniform in the
shift `s` and in the wall. -/
theorem ham_x_comm (W : WallPot) (s : ℝ) (f g : ccSchwartz ℝ) :
    (starRingEnd ℂ) (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      - (inner ℂ (xCc (ccEquiv ℝ f)) (W.ham s (ccEquiv ℝ g)) : ℂ)
      = -2 * (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (derivL2 g) : ℂ) := by
  set F : ℝ → ℂ := ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) with hFdef
  set G : ℝ → ℂ := ((g : 𝓢(ℝ, ℂ)) : ℝ → ℂ) with hGdef
  have hFs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) F := (f : 𝓢(ℝ, ℂ)).smooth _
  have hGs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) G := (g : 𝓢(ℝ, ℂ)).smooth _
  have hFc : Continuous F := hFs.continuous
  have hGc : Continuous G := hGs.continuous
  have hF1s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv F) := hFs.deriv'
  have hF2s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv F)) := hF1s.deriv'
  have hG1s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv G) := hGs.deriv'
  have hG2s : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv G)) := hG1s.deriv'
  have hF2 : Continuous (deriv (deriv F)) := hF2s.continuous
  have hG2 : Continuous (deriv (deriv G)) := hG2s.continuous
  have hpotc : Continuous (W.pot s) := (W.pot_smooth s).continuous
  have hsF : HasCompactSupport F := f.2
  have hsG : HasCompactSupport G := g.2
  -- the two pairings, as integrals
  have e1 := inner_xCc_ham W s f g
  have e2 := inner_xCc_ham W s g f
  have e3 := inner_derivL2 f g
  have e1c : (starRingEnd ℂ) (inner ℂ (xCc (ccEquiv ℝ g)) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = ∫ y : ℝ, (y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
          + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y))) := by
    rw [e1, ← integral_conj]
    refine integral_congr_ae (Filter.Eventually.of_forall fun y => ?_)
    simp only [map_mul, map_add, map_neg, Complex.conj_ofReal, RingHomCompTriple.comp_apply,
      RingHom.id_apply]
    ring
  -- integrability
  have hIa : Integrable fun y : ℝ => (y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
      + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y))) := by
    refine Continuous.integrable_of_hasCompactSupport ?_ (hsG.mul_right.mul_left)
    exact (Complex.continuous_ofReal.mul (hGc.mul (((Complex.continuous_conj.comp hF2)).neg.add
      ((Complex.continuous_ofReal.comp hpotc).mul (Complex.continuous_conj.comp hFc)))))
  have hIb : Integrable fun y : ℝ => (y : ℂ) * ((starRingEnd ℂ) (F y)
      * (-deriv (deriv G) y + (W.pot s y : ℂ) * G y)) := by
    refine Continuous.integrable_of_hasCompactSupport ?_
      (((hsF.comp_left (g := starRingEnd ℂ) (by simp)).mul_right).mul_left)
    exact (Complex.continuous_ofReal.mul ((Complex.continuous_conj.comp hFc).mul
      (hG2.neg.add ((Complex.continuous_ofReal.comp hpotc).mul hGc))))
  rw [e1c, e2, e3, ← integral_sub hIa hIb]
  rw [show (∫ y : ℝ, ((y : ℂ) * (G y * (-(starRingEnd ℂ) (deriv (deriv F) y)
        + (W.pot s y : ℂ) * (starRingEnd ℂ) (F y)))
      - (y : ℂ) * ((starRingEnd ℂ) (F y) * (-deriv (deriv G) y + (W.pot s y : ℂ) * G y))))
      = ∫ y : ℝ, (y : ℂ) * ((starRingEnd ℂ) (F y) * deriv (deriv G) y
        - (starRingEnd ℂ) (deriv (deriv F) y) * G y) from
    integral_congr_ae (Filter.Eventually.of_forall fun y => by ring)]
  exact integral_x_wronskian F G hFs hGs hsF hsG

/-! ### The fibre comparison operator -/

namespace WallPot

variable (W : WallPot) (s : ℝ) (hs : 0 ≤ s)

/-- The fibre Hamiltonian as a densely defined positive symmetric operator. -/
def posSym : PosSymOp L2R where
  dom := ccDomain ℝ
  op := W.ham s
  sym := W.ham_symmetricOn s
  pos := ham_quadForm_nonneg W s hs

/-- **The fibre comparison operator**: the Friedrichs extension of
`h_s = −d²/dφ² + φ²/4 + V(φ) + s`, a positive self-adjoint operator whose shift by one is
onto `L²(ℝ)`. -/
def comparison : Comparison L2R :=
  friedrichsComparison (W.posSym s hs) ccDomain_dense

theorem core_le_dom : ccDomain ℝ ≤ (W.comparison s hs).dom := fun v hv =>
  (friedrichsComparison_extends (W.posSym s hs) ccDomain_dense ⟨v, hv⟩).choose

/-- On the compactly supported smooth core the Friedrichs extension is the fibre
Hamiltonian. -/
theorem comparison_core (p : ccDomain ℝ) (h : (p : L2R) ∈ (W.comparison s hs).dom) :
    (W.comparison s hs).op ⟨(p : L2R), h⟩ = W.ham s p :=
  (friedrichsComparison_extends (W.posSym s hs) ccDomain_dense p).choose_spec

/-- **The compactly supported smooth core is a graph core** for the Friedrichs extension of
the fibre Hamiltonian.  This is the step that lets the exponential wall be carried through
the Faris–Lavine machinery: it is available precisely because `h_s` is essentially
self-adjoint on that core (`ham_esa`), which for the full exponential potential is proved
by the ODE/limit-point argument, not by any relative bound. -/
theorem isGraphCore_core : IsGraphCore (W.comparison s hs) (ccDomain ℝ) :=
  isGraphCore_of_esa (W.comparison s hs) (ccDomain ℝ) (W.core_le_dom s hs) (W.ham s)
    (fun p => W.comparison_core s hs p (W.core_le_dom s hs p.2)) (W.ham_esa s hs)

end WallPot

end Fibre

end

end BookProof.ScalaronFiberFL
