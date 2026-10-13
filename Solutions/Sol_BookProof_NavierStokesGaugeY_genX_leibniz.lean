-- Generated from ChapterNavierStokesGaugeY.lean — solution of BookProof.NavierStokesGaugeY.genX_leibniz
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesGaugeY




open MvPolynomial BookProof.NavierStokesFlow


@[simp] private theorem genX_apply (j : Fin 3) (p : NSAlg) : genX j p = pderiv (NSVar.x j) p := rfl

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) (p q : NSAlg) :
    genX j (p * q) = genX j p * q + p * genX j q := by

  rw [genX_apply, genX_apply, genX_apply, pderiv_mul]
