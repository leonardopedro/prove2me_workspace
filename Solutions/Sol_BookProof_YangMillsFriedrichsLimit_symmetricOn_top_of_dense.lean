-- Generated from ChapterYangMillsFriedrichsLimit.lean — solution of BookProof.YangMillsFriedrichsLimit.symmetricOn_top_of_dense
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichsLimit









open BookProof.FarisLavine BookProof.YangMillsFriedrichs



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : ∀ x y : D, (inner ℂ (A (x : F)) (y : F) : ℂ)
      = inner ℂ (x : F) (A (y : F))) :
    SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by

  -- first fix `x ∈ D` and let `y` run over the dense set
  have step1 : ∀ x : D, ∀ y : F, (inner ℂ (A (x : F)) y : ℂ) = inner ℂ (x : F) (A y) := by
    intro x
    have hcont₁ : Continuous fun y : F => (inner ℂ (A (x : F)) y : ℂ) :=
      Continuous.inner continuous_const continuous_id
    have hcont₂ : Continuous fun y : F => (inner ℂ (x : F) (A y) : ℂ) :=
      Continuous.inner continuous_const A.continuous
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro y hy
      exact hsym x ⟨y, hy⟩)
    exact fun y => congrFun this y
  -- now let `x` run over the dense set
  have step2 : ∀ y : F, ∀ x : F, (inner ℂ (A x) y : ℂ) = inner ℂ x (A y) := by
    intro y
    have hcont₁ : Continuous fun x : F => (inner ℂ (A x) y : ℂ) :=
      Continuous.inner A.continuous continuous_const
    have hcont₂ : Continuous fun x : F => (inner ℂ x (A y) : ℂ) :=
      Continuous.inner continuous_id continuous_const
    have := Continuous.ext_on hdense hcont₁ hcont₂ (by
      rintro x hx
      exact step1 ⟨x, hx⟩ y)
    exact fun x => congrFun this x
  intro x y
  exact step2 (y : F) (x : F)
