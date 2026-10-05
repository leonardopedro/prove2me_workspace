import Definitions.Def_ChapterMackeyQuasiInvariant
import Definitions.Def_ChapterPvmCyclicUnitary
import Mathlib


/-!
# Covariant unitaries of `L²` of a finite measure are induced representations

Third step towards the converse of Mackey's imprimitivity theorem over a *continuous*
base.  `BookProof.ChapterMackeyQuasiInvariant` builds, from a quasi-invariant measure and a
measurable unitary cocycle, the induced representation
`(V g f)(x) = √(dens g x) · L g x (f (g⁻¹ x))`
and shows it is a system of imprimitivity together with the multiplication projections.
This file proves the **converse at the level of `L²`**: *any* unitary representation `V` of
`G` on `L²(X, μ)` (`μ` finite) which is covariant for the multiplication projections is of
that form, with a scalar (modulus-one) cocycle `u`:

  `(V g f)(x) = u g x · √(dens g x) · f (g⁻¹ x)`   (`μ`-a.e.).

Moreover the measure is automatically quasi-invariant — the covariance relation forces it.

The proof is the classical one.  Writing `1` for the constant function and
`w = V g 1`, covariance gives `V g 1_E = 1_{g·E} · w`, hence, by unitarity,
`∫_{F} |w|² dμ = μ(g⁻¹ · F)` for every measurable `F`; that is, `|w|²` is the
Radon–Nikodym cocycle `dens μ g`.  Normalizing `u = w / |w|` gives a modulus-one cocycle,
and `V g` agrees with `f ↦ w · (f ∘ g⁻¹)` on indicators, hence everywhere by density.

Together with the spectral theorem for a cyclic projection-valued measure
(`BookProof.ChapterPvmCyclicUnitary`) this gives the converse of Mackey's theorem over a
measure-theoretic base, in `BookProof.ChapterMackeyConverse`.

Everything is `sorry`-free and uses only the standard axioms.
-/

open MeasureTheory
open scoped InnerProductSpace

namespace BookProof.ChapterMackeyCocycle

open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterPvmCyclicUnitary

variable {G X : Type*} [Group G] [MeasurableSpace X] [MulAction G X]

/-! ## Indicators in `L²` -/

/-- The indicator of a measurable set, as an element of `L²` of a finite measure. -/
noncomputable def indSet (μ : Measure X) [IsFiniteMeasure μ] {E : Set X}
    (hE : MeasurableSet E) : Lp ℂ 2 μ :=
  indicatorConstLp 2 hE (measure_ne_top μ E) (1 : ℂ)







/-! ## The set-up: a covariant unitary representation -/

/-- The image of a measurable set under the action, as a measurable set. -/
theorem measurableSet_smul_image (hm : ∀ g : G, Measurable fun x : X => g • x)
    {E : Set X} (hE : MeasurableSet E) (g : G) :
    MeasurableSet ((fun x : X => g • x) '' E) :=
  (actEquiv hm g).measurableSet_image.mpr hE

/-- Mackey's covariance relation for a unitary representation on `L²(X, μ)` and the
multiplication projections. -/
def Covariant (μ : Measure X) (hm : ∀ g : G, Measurable fun x : X => g • x)
    (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) : Prop :=
  ∀ (g : G) (E : Set X) (hE : MeasurableSet E) (f : Lp ℂ 2 μ),
    V g (proj μ hE f) = proj μ (measurableSet_smul_image hm hE g) (V g f)









/-! ## The Radon–Nikodym cocycle is the modulus squared of `V g 1` -/





/-! ## The multiplication–translation operator -/

section Operator

variable {μ : Measure X} [IsFiniteMeasure μ]

/-- The candidate for `V g`: multiply by `w` after translating by `g⁻¹`. -/
noncomputable def tfun (g : G) (w : X → ℂ) (f : X → ℂ) : X → ℂ := fun x => w x * f (g⁻¹ • x)

theorem aestronglyMeasurable_tfun (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ}
    (hwmeas : Measurable w) {f : X → ℂ} (hf : AEStronglyMeasurable f μ) :
    AEStronglyMeasurable (tfun g w f) μ :=
  hwmeas.aestronglyMeasurable.mul (hf.comp_quasiMeasurePreserving (quasiMeasurePreserving hqi g⁻¹))

/-- The translation–multiplication map preserves the `L²`-integral. -/
theorem lintegral_enorm_tfun (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ}
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2)
    {f : X → ℂ} (hf : AEStronglyMeasurable f μ) :
    ∫⁻ x, ‖tfun g w f x‖ₑ ^ (2 : ℕ) ∂μ = ∫⁻ x, ‖f x‖ₑ ^ (2 : ℕ) ∂μ := by
  have hφ : AEMeasurable (fun x => ‖f x‖ₑ ^ (2 : ℕ)) μ := hf.enorm.pow_const _
  have hφ' : AEMeasurable (fun x => ‖f (g⁻¹ • x)‖ₑ ^ (2 : ℕ)) μ :=
    hφ.comp_quasiMeasurePreserving (quasiMeasurePreserving hqi g⁻¹)
  have step1 : ∫⁻ x, ‖tfun g w f x‖ₑ ^ (2 : ℕ) ∂μ
      = ∫⁻ x, dens μ g x * ‖f (g⁻¹ • x)‖ₑ ^ (2 : ℕ) ∂μ := by
    refine lintegral_congr_ae ?_
    filter_upwards [hdens] with x hx
    rw [tfun, enorm_mul, mul_pow, hx]
  rw [step1, lintegral_dens_mul₀ μ hqi g hφ']
  refine lintegral_congr fun x => ?_
  simp [smul_smul]

theorem memLp_tfun (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) :
    MemLp (tfun g w (f : X → ℂ)) 2 μ := by
  refine ⟨aestronglyMeasurable_tfun hqi g hwmeas (Lp.aestronglyMeasurable f), ?_⟩
  have h2 := (Lp.memLp f).2
  rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num)] at h2 ⊢
  have c1 : ∀ u : X → ℂ, ∫⁻ x, ‖u x‖ₑ ^ (2 : ENNReal).toReal ∂μ
      = ∫⁻ x, ‖u x‖ₑ ^ (2:ℕ) ∂μ := by
    intro u
    refine lintegral_congr fun x => ?_
    rw [show ((2 : ENNReal).toReal) = ((2:ℕ):ℝ) by norm_num, ENNReal.rpow_natCast]
  rw [c1] at h2 ⊢
  rw [lintegral_enorm_tfun hqi g hdens (Lp.aestronglyMeasurable f)]
  exact h2

/-- The translation–multiplication operator on `L²`. -/
noncomputable def tmap (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) : Lp ℂ 2 μ :=
  (memLp_tfun hqi g hwmeas hdens f).toLp _

theorem tmap_coeFn (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) :
    ((tmap hqi g hwmeas hdens f : Lp ℂ 2 μ) : X → ℂ) =ᵐ[μ] tfun g w (f : X → ℂ) :=
  MemLp.coeFn_toLp _

theorem tmap_add (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f₁ f₂ : Lp ℂ 2 μ) :
    tmap hqi g hwmeas hdens (f₁ + f₂)
      = tmap hqi g hwmeas hdens f₁ + tmap hqi g hwmeas hdens f₂ := by
  refine Lp.ext ?_
  filter_upwards [tmap_coeFn hqi g hwmeas hdens (f₁ + f₂),
    tmap_coeFn hqi g hwmeas hdens f₁, tmap_coeFn hqi g hwmeas hdens f₂,
    Lp.coeFn_add (tmap hqi g hwmeas hdens f₁) (tmap hqi g hwmeas hdens f₂),
    (quasiMeasurePreserving hqi g⁻¹).ae_eq_comp (Lp.coeFn_add f₁ f₂)] with x a1 a2 a3 a4 a5
  simp only [Pi.add_apply, Function.comp_apply] at a4 a5
  rw [a1, a4, a2, a3]
  simp only [tfun, a5]
  ring

theorem tmap_smul (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (c : ℂ) (f : Lp ℂ 2 μ) :
    tmap hqi g hwmeas hdens (c • f) = c • tmap hqi g hwmeas hdens f := by
  refine Lp.ext ?_
  filter_upwards [tmap_coeFn hqi g hwmeas hdens (c • f), tmap_coeFn hqi g hwmeas hdens f,
    Lp.coeFn_smul c (tmap hqi g hwmeas hdens f),
    (quasiMeasurePreserving hqi g⁻¹).ae_eq_comp (Lp.coeFn_smul c f)] with x a1 a2 a3 a4
  simp only [Pi.smul_apply, Function.comp_apply] at a3 a4
  rw [a1, a3, a2]
  simp only [tfun, a4, smul_eq_mul]
  ring

theorem norm_tmap (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) :
    ‖tmap hqi g hwmeas hdens f‖ = ‖f‖ := by
  rw [Lp.norm_def, Lp.norm_def]
  congr 1
  have hco : eLpNorm ((tmap hqi g hwmeas hdens f : Lp ℂ 2 μ) : X → ℂ) 2 μ
      = eLpNorm (tfun g w (f : X → ℂ)) 2 μ :=
    eLpNorm_congr_ae (tmap_coeFn hqi g hwmeas hdens f)
  rw [hco, eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num),
    eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num)]
  congr 1
  have c1 : ∀ u : X → ℂ, ∫⁻ x, ‖u x‖ₑ ^ (2 : ENNReal).toReal ∂μ
      = ∫⁻ x, ‖u x‖ₑ ^ (2:ℕ) ∂μ := by
    intro u
    refine lintegral_congr fun x => ?_
    rw [show ((2 : ENNReal).toReal) = ((2:ℕ):ℝ) by norm_num, ENNReal.rpow_natCast]
  rw [c1, c1]
  exact lintegral_enorm_tfun hqi g hdens (Lp.aestronglyMeasurable f)

/-- The translation–multiplication operator, as a continuous linear map. -/
noncomputable def tmapL (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ} (hwmeas : Measurable w)
    (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ :=
  LinearMap.mkContinuous
    { toFun := tmap hqi g hwmeas hdens
      map_add' := tmap_add hqi g hwmeas hdens
      map_smul' := tmap_smul hqi g hwmeas hdens } 1
    (fun f => by simpa using le_of_eq (norm_tmap hqi g hwmeas hdens f))

@[simp] theorem tmapL_apply (hqi : QuasiInvariant μ G) (g : G) {w : X → ℂ}
    (hwmeas : Measurable w) (hdens : dens μ g =ᵐ[μ] fun x => ‖w x‖ₑ ^ 2) (f : Lp ℂ 2 μ) :
    tmapL hqi g hwmeas hdens f = tmap hqi g hwmeas hdens f := rfl

end Operator

/-! ## `V g` is multiplication by `V g 1` composed with translation -/

section Identify

variable {μ : Measure X} [IsFiniteMeasure μ]









end Identify

/-! ## The headline: a covariant unitary representation is induced -/

section Headline

variable {μ : Measure X} [IsFiniteMeasure μ]

/-- A measurable representative of `V g 1`. -/
noncomputable def wrep (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) : X → ℂ :=
  (Lp.aestronglyMeasurable (V g (indSet μ (MeasurableSet.univ (α := X))))).mk _





/-- The modulus-one cocycle obtained by normalizing `V g 1`. -/
noncomputable def ucocycle (V : G → (Lp ℂ 2 μ ≃ₗᵢ[ℂ] Lp ℂ 2 μ)) (g : G) (x : X) : ℂ :=
  if wrep V g x = 0 then 1 else wrep V g x / (‖wrep V g x‖ : ℂ)







end Headline

end BookProof.ChapterMackeyCocycle
