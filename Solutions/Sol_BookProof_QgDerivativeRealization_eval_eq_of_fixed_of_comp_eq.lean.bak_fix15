-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.eval_eq_of_fixed_of_comp_eq
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_configPoint_eq_jetPoint_of_fixed
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution {T T' : TetradConfig} {E E' : DerivFields}
    (hE : Fixed T E) (hE' : Fixed T' E') (hcomp : T.comp = T'.comp) (x : Fin 4 → ℝ)
    (p : MvPolynomial (Fin 84) ℂ) :
    MvPolynomial.eval (configPoint T E x) p = MvPolynomial.eval (configPoint T' E' x) p := by

  have hT : T = T' := by cases T; cases T'; simpa using hcomp
  subst hT
  rw [configPoint_eq_jetPoint_of_fixed T E hE x, configPoint_eq_jetPoint_of_fixed T E' hE' x]
