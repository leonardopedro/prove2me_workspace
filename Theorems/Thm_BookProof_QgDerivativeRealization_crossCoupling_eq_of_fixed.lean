-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.crossCoupling_eq_of_fixed
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

theorem BookProof.QgDerivativeRealization.crossCoupling_eq_of_fixed {T T' : TetradConfig} {E E' : DerivFields}
    (hE : Fixed T E) (hE' : Fixed T' E') (hcomp : T.comp = T'.comp) (x : Fin 4 → ℝ) :
    MvPolynomial.eval (configPoint T E x) crossCouplingPoly
      = MvPolynomial.eval (configPoint T' E' x) crossCouplingPoly := by sorry
