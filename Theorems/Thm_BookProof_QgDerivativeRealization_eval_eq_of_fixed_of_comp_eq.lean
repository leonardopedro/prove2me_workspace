-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.eval_eq_of_fixed_of_comp_eq
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.eval_eq_of_fixed_of_comp_eq {T T' : TetradConfig} {E E' : DerivFields}
    (hE : Fixed T E) (hE' : Fixed T' E') (hcomp : T.comp = T'.comp) (x : Fin 4 → ℝ)
    (p : MvPolynomial (Fin 84) ℂ) :
    MvPolynomial.eval (configPoint T E x) p = MvPolynomial.eval (configPoint T' E' x) p := by sorry
