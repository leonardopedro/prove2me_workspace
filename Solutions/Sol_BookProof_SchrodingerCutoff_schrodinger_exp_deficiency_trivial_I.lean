-- Generated from ChapterSchrodingerCutoffEsa.lean — solution of BookProof.SchrodingerCutoff.schrodinger_exp_deficiency_trivial_I
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Theorems.Thm_BookProof_SchrodingerCutoff_schrodinger_exp_deficiency_trivial
open BookProof.SchrodingerCutoff




open MeasureTheory Filter Complex

set_option maxHeartbeats 1000000 in
n x => by linarith [two_le_Vexp x]) hL2

theorem solution
    (u u' u'' : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt u (u' x) x)
    (h2 : ∀ x, HasDerivAt u' (u'' x) x)
    (heq : ∀ x, -u'' x + (Vexp x : ℂ) * u x = Complex.I * u x)
    (hL2 : Integr :=
  able fun x => ‖u x‖ ^ 2) :
      u = 0 :=
    schrodinger_exp_deficiency_trivial C
