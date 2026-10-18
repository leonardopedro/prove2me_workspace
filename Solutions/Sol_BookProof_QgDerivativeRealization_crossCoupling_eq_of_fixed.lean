-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.crossCoupling_eq_of_fixed
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution {T T' : TetradConfig} {E E' : DerivFields}
    (hE : Fixed T E) (hE' : Fixed T' E') (hcomp : T.comp = T'.comp) (x : Fin 4 → ℝ) :
    MvPolynomial.eval (configPoint T E x) crossCouplingPoly
      = MvPolynomial.eval (configPoint T' E' x) crossCouplingPoly := eval_eq_of_fixed_of_comp_eq hE hE' hcomp x crossCouplingPoly
